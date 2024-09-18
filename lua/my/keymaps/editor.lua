--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.keymaps.editor                                               │--
--│  DETAIL: Keybinds for editor plugins                                     │--
--│  CREATE: 2024-09-16 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-16 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keymaps = {}
local map = require("my.helpers.map")
local _ = require("my.keymaps.func")

local keymaps_editor = {
  -- Flash
  ["nxo|;"] = map.func(function() require("flash").jump() end):desc("Edit: Jump to word"),
  -- Comment
  ["n|<C-/>"] = map.func(_.comment_line):expr():desc("Edit: Comment line(s)"),
  ["n|<C-?>"] = map.func(_.comment_block):expr():desc("Edit: Comment block(s)"),
  ["v|<C-/>"] = map.key("<Plug>(comment_toggle_linewise_visual)"):desc("Edit: Comment selected lines"),
  ["v|<C-?>"] = map.key("<Plug>(comment_toggle_blockwise_visual)"):desc("Edit: Comment selected blocks"),
  -- TreeSJ
  ["n|<tab>"] = map.cmd("TSJToggle"):desc("Edit: Split/joining Code Block"),
  -- Nvim-surround - Configured in Plugin config file
    -- <s> key: surround, acted just like vim motions
    -- E.g. siw - surround word, ds" - delete surrounding ""
  -- Treesitter
    -- <cr> - incremental selection, <bs> - decremental
}

Keymaps.setup = function()
  map.setup(keymaps_editor)
end

return Keymaps
