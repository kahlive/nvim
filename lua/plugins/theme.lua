return {
	"bluz71/vim-nightfly-guicolors",
	name = "nightfly",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		-- vim.cmd.colorscheme "darkplus"
		vim.cmd.colorscheme("nightfly")
		-- 行番号
		vim.cmd([[highlight LineNr guifg=#0C8B86 gui=nocombine]])
		vim.cmd([[highlight CursorLineNr guifg=#58DCCE gui=bold]])
		-- 通常テキスト
		vim.cmd([[highlight Normal guifg=#8B9BA3 gui=nocombine]])
		-- カーソル
		vim.cmd([[highlight Cursor guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight CursorLine guibg=#073344 gui=nocombine]])
		-- 選択
		vim.cmd([[highlight Visual guibg=#092F3B gui=nocombine]])
		-- Illuminate
		vim.cmd([[highlight IlluminatedWordRead guibg=#323232 gui=nocombine]])
		vim.cmd([[highlight IlluminatedWordWrite guibg=#323232 gui=nocombine]])
		vim.cmd([[highlight IlluminatedWordText guibg=#323232 gui=nocombine]])

		vim.cmd([[highlight SpellBad guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight SpellCap guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight SpellRare guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight SpellLocal guifg=#8B9BA3 gui=nocombine]])
		-- 型
		vim.cmd([[highlight Type guifg=#AA8106 gui=nocombine]])
		vim.cmd([[highlight @type guifg=#AA8106 gui=nocombine]])
		vim.cmd([[highlight @type.builtin guifg=#AA8106 gui=nocombine]])
		vim.cmd([[highlight @type.definition guifg=#AA8106 gui=nocombine]])
		-- テキスト
		vim.cmd([[highlight @text.definition guifg=#00FFFF gui=nocombine]])
		vim.cmd([[highlight @text.literal guifg=#00FFFF gui=nocombine]])
		vim.cmd([[highlight @text.refarence guifg=#00FFFF gui=nocombine]])
		vim.cmd([[highlight @text.title guifg=#00FFFF gui=nocombine]])
		vim.cmd([[highlight @text.uri guifg=#00FFFF gui=nocombine]])
		vim.cmd([[highlight @text.underline guifg=#00FFFF gui=nocombine]])
		vim.cmd([[highlight @text.todo guifg=#00FFFF gui=nocombine]])
		-- キーワード
		vim.cmd([[highlight @keyword guifg=#7D9006 gui=nocombine]])
		vim.cmd([[highlight @operator guifg=#7D9006 gui=nocombine]])
		vim.cmd([[highlight @keyword.operator guifg=#7D9006 gui=nocombine]])
		vim.cmd([[highlight @keyword.conditional guifg=#7D9006 gui=nocombine]])
		vim.cmd([[highlight @keyword.exception guifg=#7D9006 gui=nocombine]])
		vim.cmd([[highlight @keyword.repeat guifg=#7D9006 gui=nocombine]])
		vim.cmd([[highlight @keyword.import guifg=#BF4818 gui=nocombine]])
		vim.cmd([[highlight @keyword.directive guifg=#BF4818 gui=nocombine]])
		vim.cmd([[highlight @keyword.directive.define guifg=#BF4818 gui=nocombine]])
		vim.cmd([[highlight @label guifg=#7D9006 gui=nocombine]])
		vim.cmd([[highlight @type.qualifier guifg=#7D9006 gui=nocombine]])
		vim.cmd([[highlight @include guifg=#BF4818 gui=nocombine]])
		vim.cmd([[highlight @preproc guifg=#BF4818 gui=nocombine]])
		-- リテラル
		vim.cmd([[highlight @string guifg=#0D9488 gui=nocombine]])
		vim.cmd([[highlight @string.escape guifg=#BF4818 gui=nocombine]])
		vim.cmd([[highlight @number guifg=#C7337B gui=nocombine]])
		vim.cmd([[highlight @float guifg=#C7337B gui=nocombine]])
		vim.cmd([[highlight @boolean guifg=#AA8106 gui=nocombine]])
		-- コメント
		vim.cmd([[highlight Comment guifg=#00BB00 gui=nocombine]])
		vim.cmd([[highlight @comment guifg=#00BB00 gui=nocombine]])
		vim.cmd([[highlight DiagnosticUnnecessary guifg=#3B4B53 gui=nocombine]])
		-- タグ
		vim.cmd([[highlight @tag guifg=#0F76CC gui=nocombine]])
		-- variables and functions
		vim.cmd([[highlight @punctuation guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight Function guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @function guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @function.builtin guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @function.macro guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @function.call guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @function.method guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @function.method.call guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @method guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @field guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @property guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @variable guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @variable.member guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @variable.property guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @variable.parameter guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @variable.builtin guifg=#0F76CC gui=nocombine]])
		vim.cmd([[highlight @variable.builtin.vim guifg=#0F76CC gui=nocombine]])
		vim.cmd([[highlight @namespace guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @structure guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @constant guifg=#8B9BA3 gui=nocombine]])
		vim.cmd([[highlight @constant.builtin guifg=#AA8106 gui=nocombine]])
		vim.cmd([[highlight @constant.macro guifg=#AA8106 gui=nocombine]])
		vim.cmd([[highlight @module guifg=#AA8106 gui=nocombine]])
		vim.cmd([[highlight @constructor guifg=#0F76CC gui=nocombine]])
		-- ボーダー
		vim.cmd([[highlight vertsplit guifg=fg guibg=bg]])
		-- 背景透過のための設定（透過させたいグループの背景を NONE に）
		-- vim.cmd([[
		--   highlight Normal guibg=NONE ctermbg=NONE
		--   highlight NormalNC guibg=NONE ctermbg=NONE
		--   highlight EndOfBuffer guibg=NONE ctermbg=NONE
		--   highlight SignColumn guibg=NONE ctermbg=NONE
		--   highlight VertSplit guibg=NONE ctermbg=NONE
		--   highlight LineNr guibg=NONE ctermbg=NONE
		--   highlight CursorLine guibg=NONE ctermbg=NONE
		-- ]])
	end,
}
