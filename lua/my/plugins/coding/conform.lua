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
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
  })

  vim.api.nvim_create_user_command("FormatToggle", function(args)
    local is_global = not args.bang
    if is_global then
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      if vim.g.disable_autoformat then
        vim.notify("autoformat-on-save disabled globally", vim.log.levels.info, { title = "Conform.nvim" })
      else
        vim.notify("Autoformat-on-save enabled globally", vim.log.levels.INFO, { title = "Conform.nvim" })
      end
    else
      vim.b.disable_autoformat = not vim.b.disable_autoformat
      if vim.b.disable_autoformat then
        vim.notify("Autoformat-on-save disabled for this buffer", vim.log.levels.INFO, { title = "Conform.nvim" })
      else
        vim.notify("Autoformat-on-save enabled for this buffer", vim.log.levels.INFO, { title = "Conform.nvim" })
      end
    end
  end, {
    desc = "Toggle autoformat-on-save",
    bang = true,
  })
end

return Plugin
