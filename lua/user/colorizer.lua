-- カラーコード可視化プラグイン
local M = {
	"norcalli/nvim-colorizer.lua",
	event = "VeryLazy",
}

function M.config()
	require("colorizer").setup({ "*" })
end

return M
