--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.tool.which-key                                        │--
--│ DESC: showing pending key binds                                          │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

Plugin.init = function()
  vim.o.timeout = true
  vim.o.timeoutlen = 500
end

Plugin.config = function()
  local wk = require("which-key")
  local hidden_key = require("my.helpers.filter").get("which_key_hidden", true)
  local icons = {
    ui = require("my.helpers.icons").get("ui"),
    misc = require("my.helpers.icons").get("misc"),
    git = require("my.helpers.icons").get("git", true),
    cmp = require("my.helpers.icons").get("cmp", true),
  }

  -------------------------- Which-key Config ----------------------------------
  wk.setup({
    preset = "modern",
    delay = vim.o.timeoutlen,
    triggers = {
      { "<auto>", mode = "nixso" },
    },
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        motions = false,
        operators = false,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      border = "none",
      padding = { 1, 2 },
      wo = { winblend = 0 },
    },
    expand = 1,
    icons = {
      group = "",
      rules = false,
      colors = false,
      breadcrumb = icons.ui.Separator,
      separator = icons.ui.Vbar,
    },
    spec = {
      { "<leader>g", group = icons.git.Git .. "Git" },
      { "<leader>t", group = icons.ui.ToggleOff .. " Toggle" },
      -- { "<leader>d", group = icons.ui.Bug .. " Debug" },
      -- { "<leader>s", group = icons.cmp.tmux .. "Session" },
      { "<leader>b", group = icons.ui.Buffer .. " Buffer" },
      -- { "<leader>S", group = icons.ui.Search .. " Search" },
      -- { "<leader>W", group = icons.ui.Window .. " Window" },
      -- { "<leader>p", group = icons.ui.Package .. " Package" },
      { "<leader>l", group = icons.misc.LspAvailable .. " Lsp" },
      { "<leader>f", group = icons.ui.Telescope .. " Fuzzy Find" },
      -- { "<leader>n", group = icons.ui.FolderOpen .. " Nvim Tree" },
    },
  })
end

return Plugin
