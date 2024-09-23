--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.editor.nvim-autopairs                                │--
--│  DETAIL: Auto-pair plugin for '"{[( etc.                                 │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
}

Plugin.config = function()
  local autopairs = require("nvim-autopairs")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")

  autopairs.setup({
    check_ts = true, -- enable treesitter
    ts_config = {
      lua = { "string", "source" }, -- don't add pairs in lua string treesitter nodes
      javascript = { "string", "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
    },
  })
  -- make autopairs and completion work together
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return Plugin
