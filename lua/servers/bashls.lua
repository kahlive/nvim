-- ================================================================================================
-- TITLE : bashls (Bash Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/bash-lsp/bash-language-server
-- ================================================================================================

--- @return table server configuration overrides
return function()
	return {
		filetypes = { "sh", "bash", "zsh" },
	}
end
