--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.editor.hlchunk                                       │--
--│  DETAIL: Indentation guides for Neovim                                   │--
--│  CREATE: 2024-10-02 by Benjamin Hao                                      │--
--│  UPDATE: 2024-10-02 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: config hlchunk
local Plugin = {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

Plugin.config = function()
  require("hlchunk").setup({
    chunk = {
      enable = true,
      notify = true,
      hl_group = {
        chunk = "Yellowfg",
        error = "Error",
      },
      chars = {
        horizontal_line = "─",
        vertical_line = "│",
        left_top = "╭",
        left_bottom = "╰",
        -- left_arrow = "<",
        bottom_arrow = "v",
        right_arrow = ">",
      },
      textobject = "ah",
      animate_duration = 60,
      fire_event = { "CursorHold", "CursorHoldI" },
    },
    indent = {
      enable = false,
    },
    line_num = {
      enable = false,
    },
  })
end

return Plugin
