local M = {}

local icon = require("utils.icons")
M.setup = function()
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = icon.diagnostics.BoldError,
				[vim.diagnostic.severity.WARN] = icon.diagnostics.BoldWarning,
				[vim.diagnostic.severity.INFO] = icon.diagnostics.BoldInformation,
				[vim.diagnostic.severity.HINT] = icon.diagnostics.BoldHint,
			},
		},
	})
end

return M
