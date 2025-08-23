return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
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
				"dockerfile",
			},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<TAB>",
					node_decremental = "<S-TAB>",
				},
			},
		})
	end,
}
