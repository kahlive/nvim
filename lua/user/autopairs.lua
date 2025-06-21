-- ペア記号を自動で補完するプラグイン
local M = {
	"windwp/nvim-autopairs",
}

M.config = function()
	require("nvim-autopairs").setup({
		check_ts = true,
		disable_filetype = { "TelescopePrompt", "spectre_panel" },
	})
end

return M
