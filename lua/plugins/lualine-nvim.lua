-- lua/plugins/ui.lua
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "AndreM222/copilot-lualine",
    },
    lazy = false,
    priority = 1000,
    config = function()
      -- 自作テーマはプラグインではない．utils 配下から require する．
      require("config.theme").setup({ transparent = true })  -- 不透明に戻すなら false

      require("lualine").setup({
        options = {
          theme = require("config.theme").lualine_theme(), -- 透明テーマを適用
          component_separators = "|",
          ignore_focus = { "NvimTree" },
          icons_enabled = true,
          -- globalstatus = true, -- 好みでON
        },
        sections = {
          lualine_a = {
            {
              "filename",
              file_status = true,
              newfile_status = false,
              path = 1,                -- 相対パス
              shorting_target = 40,
              symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed  = "[No Name]",
                newfile  = "[New]",
              },
            },
          },
          lualine_b = { "branch" },
          lualine_c = { "diagnostics" },
          lualine_x = { "copilot", "filetype" },
          lualine_y = { "progress" },
          lualine_z = {},
        },
        extensions = { "quickfix", "man", "fugitive" },
      })
    end,
  },
}
