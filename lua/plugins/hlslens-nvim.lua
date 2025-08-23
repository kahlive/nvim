-- 検索機能を強化するプラグイン
return {
	"kevinhwang91/nvim-hlslens",
	event = "VeryLazy",
	config = function()
		require("hlslens").setup()
		require("scrollbar.handlers.search").setup()

		vim.api.nvim_set_keymap(
			"n",
			"n",
			[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"N",
			[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<Leader><Leader>",
			[[*<Cmd>lua require('hlslens').start()<CR>Nzz]],
			{ noremap = true, silent = true }
		)
	end,
}
