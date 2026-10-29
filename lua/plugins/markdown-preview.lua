return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		vim.g.mkdp_host = "0.0.0.0"
		vim.g.mkdp_port = 62100
		vim.g.mkdp_open_to_the_world = 1
		vim.g.mkdp_echo_preview_url = 1
		vim.g.mkdp_auto_close = 0
		vim.g.mkdp_browser = "none"
		vim.g.mkdp_combine_preview = 1
		vim.g.mkdp_page_title = "Markdown Preview"
		vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/markdown-preview.css"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				vim.keymap.set("n", "<leader>mp", "<Cmd>MarkdownPreview<CR>", { buffer = true, desc = "Markdown preview" })
				vim.keymap.set("n", "<leader>ms", "<Cmd>MarkdownPreviewStop<CR>", { buffer = true, desc = "Markdown preview stop" })
				vim.keymap.set("n", "<leader>mt", "<Cmd>MarkdownPreviewToggle<CR>", { buffer = true, desc = "Markdown preview toggle" })
			end,
		})
	end,
}
