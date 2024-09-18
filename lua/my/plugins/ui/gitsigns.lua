--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.ui.gitsigns                                           │--
--│ DESC: git decorations                                                    │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
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
    signcolumn = true,
    sign_priority = 6,
    update_debounce = 100,
    word_diff = false,
    current_line_blame = true,
    diff_opts = { internal = true },
    watch_gitdir = { interval = 1000, follow_files = true },
    current_line_blame_opts = { delay = 1000, virt_text = true, virtual_text_pos = "eol" },

    on_attach = require("my.keymaps.ui").git_on_attach,

  })
end

return Plugin
