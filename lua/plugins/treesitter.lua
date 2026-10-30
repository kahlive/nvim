return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- main branch does not support lazy-loading
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"lua",
			"c",
			"cpp",
			"rust",
			"javascript",
			"typescript",
			"tsx",
			"css",
			"python",
			"bash",
			"markdown",
			"dockerfile",
			"markdown_inline",
			"json",
			"go",
			"yaml",
			"toml",
			"html",
			"vim",
		})

		-- No mdx parser exists upstream; reuse the markdown parser for .mdx buffers
		vim.treesitter.language.register("markdown", "mdx")

		-- Incremental selection is built into Nvim 0.12: use `an` / `in` in visual mode
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
			callback = function(args)
				if not pcall(vim.treesitter.start, args.buf) then
					return
				end
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if lang and vim.treesitter.query.get(lang, "indents") then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
