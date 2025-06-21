-- 視覚的なスクロールバー(縦スクロールインジケータ)を表示するプラグイン
local M = {
	"petertriho/nvim-scrollbar",
	event = "VeryLazy",
}

local new_colors = {
	blue = "#65D1FF",
	green = "#3EFFDC",
	red = "#FF0000",
	violet = "#FF61EF",
	yellow = "#FFDA7B",
	black = "#000000",
}
function M.config()
	require("scrollbar").setup({
		marks = {
			Search = { color = new_colors.green },
			Error = { color = new_colors.red },
			Warn = { color = new_colors.yellow },
			Info = { color = new_colors.blue },
			Hint = { color = new_colors.violet },
			Misc = { color = new_colors.blue },
		},
		handlers = {
			cursor = true,
			diagnostic = true,
			gitsigns = true, -- Requires gitsigns
			handle = true,
			search = true, -- Requires hlslens
			ale = false, -- Requires ALE
		},
	})
end

return M
