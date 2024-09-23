--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.keymaps.ui                                                   │--
--│  DETAIL: Keybinds for ui plugins                                         │--
--│  CREATE: 2024-09-16 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-16 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keymaps = {}
local map = require("my.helpers.map")
local _ = require("my.keymaps.func")

local keymaps_ui = {
  -- Mini.bufremove
  ["n|<Leader>bd"] = map.func(_.delete_buffer):desc("Buffer: Delete Current"),
  ["n|<Leader>bD"] = map.func(_.delete_buffer_force):desc("Buffer: Force Delete"),
  -- Bufferline
  ["n|]b"] = map.cmd("BufferLineCycleNext"):desc("Next: Buffer"),
  ["n|[b"] = map.cmd("BufferLineCyclePrev"):desc("Prev: Buffer"),
  ["n|<Leader>bc"] = map.cmd("BufferLinePickClose"):desc("Buffer: Pick Close"),
  ["n|<Leader>bC"] = map.cmd("BufferLineCloseOthers"):desc("Buffer: Close others"),
  ["n|<Leader>bs"] = map.cmd("BufferLineSortByDirectory"):desc("Buffer: Sort by Dir"),
  ["n|gb"] = map.cmd("BufferLinePick"):desc("Goto: Buffer"),
  ["n|g1"] = map.cmd("BufferLineGoToBuffer 1"):desc("Goto: Buffer 1-9"),
  ["n|g2"] = map.cmd("BufferLineGoToBuffer 2"):desc("which_key_ignore"),
  ["n|g3"] = map.cmd("BufferLineGoToBuffer 3"):desc("which_key_ignore"),
  ["n|g4"] = map.cmd("BufferLineGoToBuffer 4"):desc("which_key_ignore"),
  ["n|g5"] = map.cmd("BufferLineGoToBuffer 5"):desc("which_key_ignore"),
  ["n|g6"] = map.cmd("BufferLineGoToBuffer 6"):desc("which_key_ignore"),
  ["n|g7"] = map.cmd("BufferLineGoToBuffer 7"):desc("which_key_ignore"),
  ["n|g8"] = map.cmd("BufferLineGoToBuffer 8"):desc("which_key_ignore"),
  ["n|g9"] = map.cmd("BufferLineGoToBuffer 9"):desc("which_key_ignore"),
  -- Noice
  ["n|<Leader>md"] = map.cmd("Noice dismiss"):desc("Message: Dismiss"),
  ["n|<Leader>ml"] = map.cmd("Noice last"):desc("Message: Show Last"),
  ["n|<Leader>me"] = map.cmd("Noice error"):desc("Message: Show Error"),
  ["n|<Leader>mh"] = map.cmd("Noice history"):desc("Message: Show History"),
  -- Zen-mode
  ["n|<Leader>z"] = map.cmd("ZenMode"):desc("Zen Mode")
}

Keymaps.setup = function()
  map.setup(keymaps_ui)
end

return Keymaps

