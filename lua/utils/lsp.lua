local M = {}

M.on_attach = function(client, bufnr)
	local keymap = vim.keymap.set
	local opts = {
		noremap = true, -- prevent recursive mapping
		silent = true, -- don't print the command to the cli
		buffer = bufnr, -- restrict the keymap to the local buffer number
	}

	-- native neovim keymaps
	keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
	keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
	keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
	keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)
	keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap("n", "<leader>laa", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

	-- Format buffer
	keymap("n", "<leader>z", function()
		-- prefer synchronous formatting for immediate feedback
		vim.lsp.buf.format({ async = false })
	end, vim.tbl_extend("force", opts, { desc = "LSP: Format buffer" }))

	-- Order Imports (if supported by the client LSP)
	if client.supports_method("textDocument/codeAction") then
		keymap("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source.organizeImports" },
					diagnostics = {},
				},
				apply = true,
				bufnr = bufnr,
			})
			-- format after changing import order
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50) -- slight delay to allow for the import order to go first
		end, opts)
	end

	-- For TypeScript/TSX, prefer source definitions and jump directly
	if client.name == "ts_ls" then
		local function goto_definition_filtered()
			-- Neovim 0.11 requires position_encoding; provide client's encoding
			local enc = (client and client.offset_encoding) or "utf-16"
			local params = vim.lsp.util.make_position_params(0, enc)
			vim.lsp.buf_request(bufnr, "textDocument/definition", params, function(err, result, ctx, _)
				if err or not result then return end
				local islist = vim.islist or vim.tbl_islist
				local function is_source(loc)
					local uri = loc.uri or loc.targetUri
					if not uri then return true end
					local fname = vim.uri_to_fname(uri)
					if fname:match("%.d%.ts$") then return false end
					if fname:match("/node_modules/@types/") then return false end
					if fname:match("/node_modules/") then return false end
					return true
				end

				local list = result
				if type(result) == "table" and islist(result) then
					local filtered = {}
					for _, loc in ipairs(result) do
						if is_source(loc) then table.insert(filtered, loc) end
					end
					if #filtered > 0 then
						list = filtered
					end
				end

				local function jump_first(loclist)
					local islist = vim.islist or vim.tbl_islist
					local loc = islist(loclist) and loclist[1] or loclist
					if not loc then return end
					local uri = loc.uri or loc.targetUri
					local range = loc.range or loc.targetSelectionRange or loc.targetRange
					if not (uri and range and range.start) then return end
					local fname = vim.uri_to_fname(uri)
					vim.cmd("edit " .. vim.fn.fnameescape(fname))
					local row = (range.start.line or 0)
					local character = (range.start.character or 0)
					local enc = (ctx and ctx.client_id and (vim.lsp.get_client_by_id(ctx.client_id) or {}).offset_encoding) or "utf-16"
					local bufnr = vim.api.nvim_get_current_buf()
					local byte = character
					if vim.lsp.util._get_line_byte_from_position then
						byte = vim.lsp.util._get_line_byte_from_position(bufnr, { line = row, character = character }, enc)
					end
					vim.api.nvim_win_set_cursor(0, { row + 1, byte })
				end

				-- Prefer built-in handler if available, else fallback jump
				local handler = vim.lsp.handlers and vim.lsp.handlers["textDocument/definition"] or nil
				if type(handler) == "function" then
					handler(nil, list, ctx, { reuse_win = true })
				else
					jump_first(list)
				end
			end)
		end

		-- Override gd for this buffer only (ts/tsx/js/jsx)
		local ft = vim.bo[bufnr].filetype
		if ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
			keymap("n", "gd", goto_definition_filtered, vim.tbl_extend("force", opts, { desc = "LSP: Go to source definition" }))
		end
	end

	-- Attach breadcrumbs (nvim-navic) if the server supports document symbols
	local ok_navic, navic = pcall(require, "nvim-navic")
	if ok_navic and client.server_capabilities and client.server_capabilities.documentSymbolProvider and client.name ~= "efm" then
		navic.attach(client, bufnr)
	end
end

return M
