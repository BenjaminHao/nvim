--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.editor.highlight-colors                              │--
--│  DETAIL: Highlight colors within Neovim                                  │--
--│  CREATE: 2024-09-19 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPre", "BufNewFile" },
}

Plugin.config = function()
  require("nvim-highlight-colors").setup({
    render = "background",
    enable_hex = true,
    enable_short_hex = true,
    enable_rgb = true,
    enable_hsl = true,
    enable_var_usage = true,
    enable_named_colors = false,
    enable_tailwind = false,
    -- Exclude filetypes or buftypes from highlighting
    exclude_filetypes = {
      "alpha",
      "bigfile",
      "dap-repl",
      "fugitive",
      "git",
      "notify",
      "NvimTree",
      "Outline",
      "TelescopePrompt",
      "toggleterm",
      "undotree",
    },
    exclude_buftypes = {
      "nofile",
      "prompt",
      "terminal",
    },
  })
end

return Plugin
