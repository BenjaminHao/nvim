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

Plugin.config = function()
  local blend_color = require("my.helpers.color").gen_neodim_blend_attr()

  require("neodim").setup({
    alpha = 0.45,
    blend_color = blend_color,
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
