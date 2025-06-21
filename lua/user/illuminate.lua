-- 現在カーソルがある単語と同じ単語を自動でハイライトしてくれるプラグイン
local M = {
	"RRethy/vim-illuminate",
	event = "VeryLazy",
}

function M.config()
	require("illuminate").configure({
		filetypes_denylist = {
			"mason",
			"harpoon",
			"DressingInput",
			"NeogitCommitMessage",
			"qf",
			"dirvish",
			"oil",
			"minifiles",
			"fugitive",
			"alpha",
			"NvimTree",
			"lazy",
			"NeogitStatus",
			"Trouble",
			"netrw",
			"lir",
			"DiffviewFiles",
			"Outline",
			"Jaq",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"TelescopePrompt",
		},
	})
end

return M
