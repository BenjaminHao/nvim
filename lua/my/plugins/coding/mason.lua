--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.coding.mason                                         │--
--│  DETAIL: Package manager for LSP servers                                 │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-14 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: icons
local Plugin = {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonInstall" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim"
  },
}

Plugin.config = function()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "󰗡",
        package_pending = "󰦕",
        package_uninstalled = "󰄰",
      },
      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        check_server_version = "c",
        update_all_servers = "U",
        check_outdated_servers = "C",
        uninstall_server = "X",
        cancel_installation = "<C-c>",
      },
      max_concurrent_installers = 5,
    },
  })

  mason_lspconfig.setup({
    -- list of servers for mason to install
    -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
    ensure_installed = {
      "clangd",    -- C/C++
      "html",      -- HTML
      "jdtls",     -- Java
      "jsonls",    -- Json
      "lua_ls",    -- Lua
      "pylsp",     -- Python
      "marksman",  -- Markdown
    },
    -- auto-install configured servers (with lspconfig)
    automatic_installation = true, -- not the same as ensure_installed
  })
end

return Plugin
