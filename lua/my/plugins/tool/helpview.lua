--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.tool.helpview                                        │--
--│  DETAIL: Help file previewer                                             │--
--│  CREATE: 2024-10-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-10-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "OXY2DEV/helpview.nvim",
  ft = "help",
  dependencies = {
    "nvim-treesitter/nvim-treesitter"
  }
}

Plugin.config = function()
  require("helpview").setup()
end

return Plugin
