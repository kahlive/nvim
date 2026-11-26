-- ================================================================================================
-- TITLE : biome LSP Setup
-- ABOUT : attaches only under a Biome config (nvim-lspconfig's root_dir); where it attaches, it
--         owns formatting and linting and efm stays off (utils/lsp.lua's biome_attaches)
-- LINKS :
--   > website: https://biomejs.dev
-- ================================================================================================

--- @return table server configuration overrides
return function()
	return {
		-- only the filetypes Biome formats; markdown, html, yaml, svelte, vue and astro stay with efm
		filetypes = {
			"css",
			"graphql",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"typescript",
			"typescriptreact",
		},
	}
end
