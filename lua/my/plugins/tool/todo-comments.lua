--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.tool.todo-comments                                   │--
--│  DETAIL: Highlight and search for todo comments                          │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: icons
local Plugin = {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TodoTrouble", "TodoTelescope" },
}

Plugin.config = function()

  require("todo-comments").setup({
    signs = false, -- show icons in the signs column
    keywords = {
      TODO = { icon = "󰝖 ", color = "info" },
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG" }},
      NOTE = { icon = " ", color = "hint", alt = { "INFO", "HELP" }},
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING" }},
      PERF = { icon = "󰁫 " },
      TEST = { icon = " ", color = "test" },
    },
    gui_style = {
      fg = "NONE",
      bg = "BOLD",
    },
    merge_keywords = true,
    highlight = {
      multiline = false,
      before = "",
      keyword = "wide",
      after = "fg",
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = { "txt", "man", "markdown" }, -- list of file types to exclude highlighting
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#F5C2E7" },
      default = { "Conditional", "#7C3AED" },
    },
  })
end

return Plugin
