--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.ui.dressing                                          │--
--│  DETAIL: Promt improvement plugin                                        │--
--│  CREATE: 2024-09-19 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
}

Plugin.config = function()
  require("dressing").setup({
    input = {
      default_prompt = "󰘎 Input",
      title_pos = "center",
      relative = "cursor",
      prefer_width = 30,
      width = nil,
      -- min_width and max_width can be a list of mixed types.
      -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
      max_width = { 140, 0.9 },
      min_width = { 20, 0.2 },
      -- win_options = {
      --   winhighlight = "NormalFloat:TelescopePromptNormal,FloatBorder:TelescopePromptBorder,FloatTitle:TelescopePromptTitle",
      -- }
    },
    select = {
      backend = { "telescope", "nui", "builtin" },
      -- telescope = require('telescope.themes').get_cursor(),
    },
  })
end

return Plugin
