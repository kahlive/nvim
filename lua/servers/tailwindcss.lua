-- ================================================================================================
-- TITLE : tailwindcss LSP Setup
-- LINKS :
--   > github: https://github.com/tailwindlabs/tailwindcss-intellisense
-- ================================================================================================

--- @return table server configuration overrides
return function()
	return {
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
	}
end
