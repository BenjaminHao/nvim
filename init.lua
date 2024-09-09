--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: nvim                                                            │--
--│  DETAIL: Entry point of Neovim config                                    │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
require("my.configs.autocmds").setup()
require("my.configs.keymaps").setup()
require("my.configs.options").setup()
require("my.configs.systems").setup()
require("my.plugins.manager").setup()
