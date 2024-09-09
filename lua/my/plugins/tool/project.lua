--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.tool.project                                          │--
--│ DESC: Project management plugin                                          │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy", -- TODO: change lazy load
}

Plugin.config = function()
  require("project_nvim").setup({
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    ignore_lsp = { "null-ls", "copilot" },
    exclude_dirs = {},
    show_hidden = false,
    silent_chdir = true,
    scope_chdir = "global",
    datapath = vim.fn.stdpath("data"),
  })
end

return Plugin
