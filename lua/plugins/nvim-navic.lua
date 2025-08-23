-- ================================================================================================
-- TITLE : nvim-navic (LSP breadcrumbs)
-- ABOUT : Show code context breadcrumbs in the winbar via LSP document symbols.
-- LINKS : https://github.com/SmiteshP/nvim-navic
-- ================================================================================================

return {
  "SmiteshP/nvim-navic",
  event = "LspAttach",
  opts = {
    highlight = true,
    separator = "  ",
    depth_limit = 0, -- 0 means no limit
    safe_output = true,
  },
  config = function(_, opts)
    require("nvim-navic").setup(opts)
  end,
}

