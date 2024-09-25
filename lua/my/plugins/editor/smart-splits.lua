--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.editor.smart-splits                                  │--
--│  DETAIL: Pane management plugin                                          │--
--│  CREATE: 2024-09-19 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
}

Plugin.config = function()
  require("smart-splits").setup({
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = {
      "nofile",
      "quickfix",
      "prompt",
    },
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = { "NvimTree" },
    -- the default number of lines/columns to resize by at a time
    default_amount = 3,
    -- whether the cursor should follow the buffer when swapping
    cursor_follows_swapped_bufs = true,
  })
end

return Plugin
