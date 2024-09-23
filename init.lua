--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: nvim init                                                       │--
--│  DETAIL: Entry point of Neovim config                                    │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-20 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- Configs
require("my.configs.systems").setup()
require("my.configs.options").setup()
require("my.configs.autocmds").setup()
-- Keymaps
require("my.keymaps.core").setup()
require("my.keymaps.ui").setup()
require("my.keymaps.lsp").setup()
require("my.keymaps.tools").setup()
require("my.keymaps.editor").setup()
-- Plugins
require("my.plugins.manager").setup()
