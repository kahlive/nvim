return {
	"ojroques/nvim-osc52",
	event = "VeryLazy",
	config = function()
		require("osc52").setup({
			max_length = 0, -- 無制限
			silent = false, -- 成功メッセージを出さない
			trim = false, -- 末尾の改行を削除しない
		})
		vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
		vim.keymap.set("x", "<leader>y", require("osc52").copy_visual)
	end,
}
