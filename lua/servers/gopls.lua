-- ================================================================================================
-- TITLE : gopls (Golang Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/golang/tools/tree/master/gopls
-- ================================================================================================

--- @return table server configuration overrides
return function()
	return {
		filetypes = { "go" },
	}
end
