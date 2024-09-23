--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.editor.gitsigns                                      │--
--│  DETAIL: Git decorations                                                 │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
--TODO: change sign icons & hl
local Plugin = {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

Plugin.config = function()
  require("gitsigns").setup({
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    auto_attach = true,
    on_attach = require("my.keymaps.editor").git_on_attach,
    signcolumn = true,
    sign_priority = 6,
    update_debounce = 100,
    word_diff = false,
    current_line_blame = true,
    diff_opts = { internal = true },
    watch_gitdir = { interval = 1000, follow_files = true },
    current_line_blame_opts = { delay = 1000, virt_text = true, virtual_text_pos = "eol" },
  })
end

return Plugin
