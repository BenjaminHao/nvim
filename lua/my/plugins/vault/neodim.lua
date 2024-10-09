--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.ui.neodim                                            │--
--│  DETAIL: Dimming the highlights of unused variables, etc.                │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "zbirenbaum/neodim",
  event = "LspAttach",
}

local function blend_color()
  local trans_bg = require("my.configs.settings").transparent_background
  local appearance = require("my.configs.settings").background
  local color = require("my.helpers.colors")

  if trans_bg and appearance == "dark" then
    return "#000000"
  elseif trans_bg and appearance == "light" then
    return "#FFFFFF"
  else
    return color.hl_to_rgb("Normal", true)
  end
end

Plugin.config = function()
  require("neodim").setup({
    alpha = 0.45,
    blend_color = blend_color(),
    refresh_delay = 75, -- time in ms to wait after typing before refreshing diagnostics
    hide = {
      virtual_text = true,
      signs = false,
      underline = false,
    },
    priority = 80,
    disable = {
      "alpha",
      "bigfile",
      "checkhealth",
      "dap-repl",
      "diff",
      "fugitive",
      "fugitiveblame",
      "git",
      "gitcommit",
      "help",
      "log",
      "notify",
      "NvimTree",
      "Outline",
      "qf",
      "TelescopePrompt",
      "text",
      "toggleterm",
      "undotree",
      "vimwiki",
    },
  })
end

return Plugin
