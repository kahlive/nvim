-- ================================================================================================
-- TITLE : LSP Hover/Float Styling
-- ABOUT : Improve the look of LSP hover (K) and other floats
-- ================================================================================================

-- Rounded borders and sane defaults for diagnostics float
vim.diagnostic.config({
  float = {
    border = "rounded",
    source = "if_many",
    focusable = false,
    max_width = 88,
    max_height = 24,
  },
})

-- Style all LSP floating previews (affects hover, signature help, etc.)
local orig = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  opts.max_width = opts.max_width or 88
  opts.max_height = opts.max_height or 24
  opts.focusable = (opts.focusable ~= false)
  opts.winblend = opts.winblend or 0
  -- Nice-to-have: title if supported (harmless if ignored)
  opts.title = opts.title or ""
  opts.title_pos = opts.title_pos or "center"

  local bufnr, winnr = orig(contents, syntax, opts, ...)
  if winnr and vim.api.nvim_win_is_valid(winnr) then
    -- better wrapping/linebreaks for readability
    vim.wo[winnr].wrap = true
    vim.wo[winnr].linebreak = true
    vim.wo[winnr].breakindent = true
    -- consistent highlights
    pcall(vim.api.nvim_set_option_value, "winhl", "Normal:NormalFloat,FloatBorder:FloatBorder", { scope = "win", win = winnr })
  end
  return bufnr, winnr
end
