return {
	"MeanderingProgrammer/markdown.nvim",
	-- Load on filetype rather than VeryLazy: the plugin's own plugin/ init (see
	-- render-markdown/core/manager.lua M.init) attaches the current buffer *before* this
	-- config runs, so with VeryLazy the first buffer is matched against the default
	-- file_types, which lack 'mdx'. With `ft` set, lazy.nvim re-fires FileType and the
	-- plugin's own autocmd attaches after setup.
	ft = { "markdown", "mdx" },
	config = function()
		require("render-markdown").setup({
			-- .mdx uses the 'mdx' filetype (see lua/config/autocmds.lua); the default
			-- file_types list only covers 'markdown'
			file_types = { "markdown", "mdx" },
		})
	end,
}
