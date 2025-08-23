local M = {}

local function should_disable()
  -- disable for special buffers and floating windows
  if vim.api.nvim_win_get_config(0).relative ~= "" then return true end
  local bt = vim.bo.buftype
  if bt ~= "" and bt ~= "acwrite" then return true end
  local disabled_filetypes = {
    alpha = true,
    dashboard = true,
    help = true,
    qf = true,
    starter = true,
    fugitive = true,
    gitcommit = true,
    Trouble = true,
    lazy = true,
    mason = true,
    ["TelescopePrompt"] = true,
    toggleterm = true,
    terminal = true,
    ["neo-tree"] = true,
    NvimTree = true,
  }
  return disabled_filetypes[vim.bo.filetype] or false
end

function M.eval()
  if should_disable() then return "" end

  local ok_icons, icons = pcall(require, "utils.icons")
  local sep = ok_icons and (" " .. (icons.ui and icons.ui.ChevronRight or ">") .. " ") or " > "

  -- filename (start of breadcrumbs)
  local name = vim.api.nvim_buf_get_name(0)
  local filename = (name == "" or name == nil) and "[No Name]" or vim.fn.fnamemodify(name, ":t")

  -- saved/unsaved indicator inline with filename
  local modified = vim.bo.modified
  local status = modified and " ●" or " ✓"
  local out = filename .. status

  -- breadcrumbs from navic
  local ok_navic, navic = pcall(require, "nvim-navic")
  if ok_navic and navic.is_available() then
    local loc = navic.get_location({ separator = sep, safe_output = true })
    if loc and loc ~= "" then
      out = out .. sep .. loc
    end
  end

  return out
end

return M
