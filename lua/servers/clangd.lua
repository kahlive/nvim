-- ================================================================================================
-- TITLE : clangd (C/C++ Language Server) LSP Setup
-- LINKS :
--   > website: https://clangd.llvm.org/
-- ================================================================================================

--- @return table server configuration overrides
return function()
	return {
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
		filetypes = { "c", "cpp" },
	}
end
