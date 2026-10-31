-- ================================================================================================
-- TITLE : tailwind-tools
-- ABOUT : An unofficial Tailwind CSS integration and tooling for Neovim.
-- LINKS :
--   > github : https://github.com/Eingin/tailwind-tools.nvim
-- ================================================================================================

return {
	"Eingin/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		server = {
			override = false,
		},
	},
}
