--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.tool.zen-mode                                        │--
--│  DETAIL: Distracion-free environment, hide ui                            │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  dependencies = {
    "folke/twilight.nvim",  -- dims inactive portions of the code
  },
}

Plugin.config = function ()
    local zenmode = require("zen-mode")

    zenmode.setup(
      {
        window = {
          backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          -- height and width can be:
          -- * an absolute number of cells when > 1
          -- * a percentage of the width / height of the editor when <= 1
          -- * a function that returns the width or the height
          width = 100, -- width of the Zen window
          height = 1, -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
            -- you may turn on/off statusline in zen mode by setting "laststatus" 
            -- statusline will be shown only if "laststatus" == 3
            laststatus = 0, -- turn off the statusline in zen mode
          },
          twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = true }, -- disable git signs | true as disable?!
          tmux = { enabled = false }, -- disables the tmux statusline

          -- this will change the font size on wezterm when in zen mode
          -- Wezterm config is required, see Plugins/Wezterm section in README.md
          wezterm = {
            enabled = true,
            -- can be either an absolute font size or the number of incremental steps
            font = "+2", -- (10% increase per step)
          },
        },
        -- callback where you can add custom code when the Zen window opens
        -- on_open = function(win)
        -- end,
        -- callback where you can add custom code when the Zen window closes
        -- on_close = function()
        -- end,
      })
  end

return Plugin
