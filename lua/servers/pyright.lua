-- ================================================================================================
-- TITLE : pyright (Python Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/microsoft/pyright
-- ================================================================================================

--- @return table server configuration overrides
return function()
	return {
		settings = {
			pyright = {
				disableOrganizeImports = false,
			},
			python = {
				analysis = {
					typeCheckingMode = "standard",
					diagnosticMode = "workspace",
					autoSearchPaths = true,
					autoImportCompletions = true,
					useLibraryCodeForTypes = true,
				},
			},
		},
	}
end
