-- ================================================================================================
-- TITLE : Winbar (breadcrumbs + modified status)
-- ABOUT : Provides a global winbar that shows a saved/unsaved indicator and LSP breadcrumbs
-- ================================================================================================

-- Set winbar to evaluate our renderer function
vim.o.winbar = "%{%v:lua.require('utils.winbar').eval()%}"

-- Refresh winbar on relevant events
local aug = vim.api.nvim_create_augroup("WinbarBreadcrumbs", { clear = true })
vim.api.nvim_create_autocmd({ "CursorMoved", "InsertLeave", "BufWritePost", "TextChanged", "LspAttach" }, {
  group = aug,
  callback = function()
    vim.cmd("redrawstatus")
  end,
})

