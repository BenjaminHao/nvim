--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: nvim                                                            │--
--│  DETAIL: Entry point of Neovim config                                    │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
require("my.configs.autocmds").setup()
require("my.configs.options").setup()
require("my.configs.systems").setup()
require("my.keymaps.core").setup()
require("my.keymaps.ui").setup()
require("my.keymaps.tools").setup()
require("my.keymaps.editor").setup()
require("my.keymaps.completion").setup()
require("my.plugins.manager").setup()
