-- カラーコード可視化プラグイン
return {
	"catgoose/nvim-colorizer.lua",
	event = "VeryLazy",
	config = function()
		require("colorizer").setup({ filetypes = { "*" } })
	end,
}
