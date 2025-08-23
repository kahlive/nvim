-- カラーコード可視化プラグイン
return {
	"norcalli/nvim-colorizer.lua",
	event = "VeryLazy",
	config = function()
		require("colorizer").setup({ "*" })
	end,
}
