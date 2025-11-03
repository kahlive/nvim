-- ================================================================================================
-- TITLE : ts_ls (TypeScript Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/typescript-language-server/typescript-language-server
-- ================================================================================================

--- @return table server configuration overrides
return function()
	return {
		filetypes = {
			"typescript",
			"javascript",
			"typescriptreact",
			"javascriptreact",
		},
		handlers = {
			["textDocument/definition"] = function(err, result, ctx, config)
				local default_handler = vim.lsp.handlers["textDocument/definition"]
				if err or not result then
					return default_handler(err, result, ctx, config)
				end

				local function is_source(loc)
					local uri = loc.uri or loc.targetUri
					if not uri then return true end
					local fname = vim.uri_to_fname(uri)
					-- Exclude declaration files and DefinitelyTyped
					if fname:match("%.d%.ts$") then return false end
					if fname:match("/node_modules/@types/") then return false end
					-- Prefer project sources over node_modules when both exist
					if fname:match("/node_modules/") then return false end
					return true
				end

				local filtered = result
				local islist = vim.islist or vim.tbl_islist
				if type(result) == "table" and islist(result) then
					local tmp = {}
					for _, loc in ipairs(result) do
						if is_source(loc) then table.insert(tmp, loc) end
					end
					if #tmp > 0 then
						filtered = tmp
					end
				end

				if type(default_handler) == "function" then
					return default_handler(nil, filtered, ctx, config)
				end

				-- Fallback jump to first source location without deprecated API
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
					local enc = (ctx
							and ctx.client_id
							and (vim.lsp.get_client_by_id(ctx.client_id) or {}).offset_encoding)
						or "utf-16"
					local bufnr = vim.api.nvim_get_current_buf()
					local byte = character
					if vim.lsp.util._get_line_byte_from_position then
						byte = vim.lsp.util._get_line_byte_from_position(bufnr, { line = row, character = character }, enc)
					end
					vim.api.nvim_win_set_cursor(0, { row + 1, byte })
				end

				return jump_first(filtered)
			end,
		},
		settings = {
			typescript = {
				indentStyle = "space",
				indentSize = 2,
				-- Prefer jumping to source definitions over .d.ts
				preferences = {
					preferGoToSourceDefinition = true,
				},
			},
			javascript = {
				-- Keep JS behavior consistent with TS
				preferences = {
					preferGoToSourceDefinition = true,
				},
			},
		},
	}
end
