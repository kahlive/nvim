-- 検索機能を強化するプラグイン
local M = {
	"kevinhwang91/nvim-hlslens",
	event = "VeryLazy",
}

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
function M.config()
	require("hlslens").setup()
	require("scrollbar.handlers.search").setup()

	keymap("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]], opts)
	keymap("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]], opts)
	keymap("n", "<Leader><Leader>", [[*<Cmd>lua require('hlslens').start()<CR>Nzz]], opts)
end

return M
