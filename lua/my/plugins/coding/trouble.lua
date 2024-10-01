--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.coding.trouble                                       │--
--│  DETAIL: Diagnostics & quickfix plugin                                   │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "folke/trouble.nvim",
  cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
}

Plugin.config = function()
  local icons = {
    ui = require("my.helpers.icons").get("ui", true),
  }

  require("trouble").setup({
    auto_open = false,
    auto_close = false,
    auto_jump = false,
    auto_preview = true,
    auto_refresh = true,
    focus = false, -- do not focus the window when opened
    follow = true,
    restore = true,
    icons = {
      indent = {
        fold_open = icons.ui.ArrowOpen,
        fold_closed = icons.ui.ArrowClosed,
      },
      folder_closed = icons.ui.Folder,
      folder_open = icons.ui.FolderOpen,
    },
    modes = {
      project_diagnostics = {
        mode = "diagnostics",
        filter = {
          any = {
            {
              function(item)
                return item.filename:find(vim.fn.getcwd(), 1, true)
              end,
            },
          },
        },
      },
    },
  })end

return Plugin
