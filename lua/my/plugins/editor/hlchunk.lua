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
  local colors = require("catppuccin.palettes").get_palette("mocha")

  require("hlchunk").setup({
    chunk = {
      enable = true,
      style = {
        { fg = colors.sky },  -- for chunk indicator
        { fg = colors.red },  -- for error indicator
      },
      chars = {
        horizontal_line = "─",
        vertical_line = "│",
        left_top = "╭",
        left_bottom = "╰",
        right_arrow = ">",
      },
      error_sign = false,
      duration = 60,
      delay = 300;
    },
    indent = {
      enable = false,
      style =  colors.sky,
      chars = { "│" },
    },
    blank = {
      enable = false,
      chars = { "·" },
    },
    line_num = {
      enable = true,
      style = colors.sky,
    },
  })
end

return Plugin
