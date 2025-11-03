-- ================================================================================================
-- TITLE : jsonls (JSON Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/microsoft/vscode-json-languageservice
-- ================================================================================================

--- @return table server configuration overrides
return function()
	return {
		filetypes = { "json", "jsonc" },
	}
end
