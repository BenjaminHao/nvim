--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.editor.nvim-spider                                   │--
--│  DETAIL: Jump to subwords                                                │--
--│  CREATE: 2024-10-07 by Benjamin Hao                                      │--
--│  UPDATE: 2024-10-07 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "chrisgrieser/nvim-spider",
  cmd = { "SpiderW", "SpiderE", "SpiderB" },
}

Plugin.config = function()
  vim.api.nvim_create_user_command("SpiderW", "lua require('spider').motion('w')", {})
  vim.api.nvim_create_user_command("SpiderE", "lua require('spider').motion('e')", {})
  vim.api.nvim_create_user_command("SpiderB", "lua require('spider').motion('b')", {})
  require("spider").setup {
    skipInsignificantPunctuation = true,
    consistentOperatorPending = false, -- see "Consistent Operator-pending Mode" in the README
    subwordMovement = true,
    customPatterns = {}, -- check "Custom Movement Patterns" in the README for details
  }
end

return Plugin
