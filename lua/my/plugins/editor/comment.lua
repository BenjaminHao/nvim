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

Plugin.init = function()
  local map = require("my.helpers.map")

  local function comment_line()
    return vim.v.count == 0
      and "<Plug>(comment_toggle_linewise_current)"
      or "<Plug>(comment_toggle_linewise_count)"
  end

  local function comment_block()
    return vim.v.count == 0
      and "<Plug>(comment_toggle_blockwise_current)"
      or "<Plug>(comment_toggle_blockwise_count)"
  end

  local keymaps = {
    ["n|<C-/>"] = map.func(comment_line):expr():desc("Edit: Comment line(s)"),
    ["n|<C-?>"] = map.func(comment_block):expr():desc("Edit: Comment block(s)"),
    ["v|<C-/>"] = map.key("<Plug>(comment_toggle_linewise_visual)"):desc("Edit: Comment selected lines"),
    ["v|<C-?>"] = map.key("<Plug>(comment_toggle_blockwise_visual)"):desc("Edit: Comment selected blocks"),
  }

  map.setup(keymaps)
end

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
