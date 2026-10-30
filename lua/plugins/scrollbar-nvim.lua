-- 視覚的なスクロールバー(縦スクロールインジケータ)を表示するプラグイン
local new_colors = {
	blue = "#65D1FF",
	green = "#3EFFDC",
	red = "#FF0000",
	violet = "#FF61EF",
	yellow = "#FFDA7B",
	black = "#000000",
}
return {
	"petertriho/nvim-scrollbar",
	-- TODO: 2026-11-16 に v2 が main へマージされたら branch 指定を削除する
	branch = "refactor/v2",
	event = "VeryLazy",
	config = function()
		require("scrollbar").setup({
			marks = {
				Search = { highlight = { fg = new_colors.green } },
				Error = { highlight = { fg = new_colors.red } },
				Warn = { highlight = { fg = new_colors.yellow } },
				Info = { highlight = { fg = new_colors.blue } },
				Hint = { highlight = { fg = new_colors.violet } },
				Misc = { highlight = { fg = new_colors.blue } },
			},
			providers = {
				cursor = true,
				diagnostic = true,
				gitsigns = true, -- Requires gitsigns
				search = true,
				ale = false, -- Requires ALE
			},
		})
	end,
}
