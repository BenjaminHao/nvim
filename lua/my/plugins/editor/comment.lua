--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.editor.comment                                        │--
--│ DESC: plugin for commenting                                              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}

Plugin.config = function()
  local comment = require("Comment")
  local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

  comment.setup({
    padding = true,
    sticky = true,
    ignore = "^$",
    pre_hook = ts_context_commentstring.create_pre_hook(),
    mappings = {
      basic = false,
      extra = false,
    },
  })

end

return Plugin
