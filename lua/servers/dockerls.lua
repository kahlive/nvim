-- ================================================================================================
-- TITLE : dockerls (Docker Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/rcjsuen/dockerfile-language-server-nodejs
-- ================================================================================================

--- @return table server configuration overrides
return function()
	return {
		filetypes = { "dockerfile" },
	}
end
