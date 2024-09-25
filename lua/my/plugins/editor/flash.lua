--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.editor.flash                                         │--
--│  DETAIL: Enhanced motions, fast jump to word                             │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "folke/flash.nvim",
  event = "VeryLazy",
}

Plugin.config = function()
  require("flash").setup({
    labels = "asdfghjklqwertyuiopzxcvbnm",
    label = {
      -- allow uppercase labels
      uppercase = true,
      -- add a label for the first match in the current window.
      -- you can always jump to the first match with `<CR>`
      current = true,
      -- for the current window, label targets closer to the cursor first
      distance = true,
    },
    modes = {
      search = { enabled = false },
      -- options used when flash is activated through
      -- `f`, `F`, `t`, `T`, `;` and `,` motions
      char = {
        enabled = true,
        -- hide after jump when not using jump labels
        autohide = false,
        -- show jump labels
        jump_labels = false,
        -- set to `false` to use the current line only
        multi_line = true,
        -- When using jump labels, don't use these keys
        -- This allows using those keys directly after the motion
        label = { exclude = "hjkliardc" },
        -- IMPORTANT: NOT using ;/, keep pressing f/t to go to the next
        keys = { "f", "F", "t", "T", },
      },
    },
    prompt = {
      enabled = true,
      prefix = { { " 󰓾 ", "FlashPromptIcon" } },
      win_config = {
        relative = "editor",
        width = 1, -- when <=1 it's a percentage of the editor width
        height = 1,
        row = -1, -- when negative it's an offset from the bottom
        col = 0, -- when negative it's an offset from the right
        zindex = 1000,
      },
    },
  })
end

return Plugin
