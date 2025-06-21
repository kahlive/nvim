local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting
	-- local diagnostics = null_ls.builtins.diagnostics
	local completion = null_ls.builtins.completion

	local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
	local event = "BufWritePre" -- or "BufWritePost"
	local async = event == "BufWritePost"

	null_ls.setup({
		debug = false,
		sources = {
			formatting.stylua,
			formatting.prettier,
			formatting.black,
			-- formatting.prettier.with {
			--   extra_filetypes = { "toml" },
			--   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
			-- },
			-- formatting.eslint,
			-- diagnostics.flake8,
			completion.spell,
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.keymap.set("n", "<Leader>z", function()
					vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
				end, { buffer = bufnr, desc = "[lsp] format" })

				-- format on save
				local ft = vim.bo[bufnr].filetype
				if
					ft ~= "typescript"
					and ft ~= "typescriptreact"
					and ft ~= "python"
					and ft ~= "json"
					and ft ~= "yaml"
				then
					vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
					vim.api.nvim_create_autocmd(event, {
						buffer = bufnr,
						group = group,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, async = async })
						end,
						desc = "[lsp] format on save",
					})
				end
			end

			if client.supports_method("textDocument/rangeFormatting") then
				vim.keymap.set("x", "<Leader>z", function()
					vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
				end, { buffer = bufnr, desc = "[lsp] format" })
			end
		end,
	})
end

return M
