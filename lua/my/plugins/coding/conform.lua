--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.coding.conform                                       │--
--│  DETAIL: Formatter plugin                                                │--
--│  CREATE: 2024-10-09 by Benjamin Hao                                      │--
--│  UPDATE: 2024-10-09 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

Plugin.config = function()
  require("conform").setup({
    formatters_by_ft = {
      -- Be sure to installed by Mason
      c = { "clang_format" },
      cpp = { "clang_format" },
      html = { "prettier" },
      java = { "google-java-format" },
      javascript = { "prettier", stop_after_first = true },
      javascriptreact = { "prettier", stop_after_first = true },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      python = { "black" },
      typescript = { "prettier", stop_after_first = true },
      typescriptreact = { "prettier", stop_after_first = true },
    },
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  })
end

return Plugin
