-- インデントガイドを表示するためのプラグイン
return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "VeryLazy",
	config = function()
		local icons = require("utils.icons")

		require("ibl").setup({
			exclude = {
				buftypes = { "terminal", "nofile" },
				filetypes = {
					"help",
					"startify",
					"dashboard",
					"lazy",
					"neogitstatus",
					"NvimTree",
					"Trouble",
					"text",
				},
			},
			indent = {
				char = icons.ui.LineMiddle,
			},
			scope = {
				enabled = true,
				char = icons.ui.LineMiddle,
			},
		})
	end,
}
