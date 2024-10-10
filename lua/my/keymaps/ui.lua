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
  ["n|<Leader>bc"] = map.cmd("BufferLinePickClose"):desc("Buffer: Pick Close"),
  ["n|<Leader>bC"] = map.cmd("BufferLineCloseOthers"):desc("Buffer: Close others"),
  ["n|<Leader>bs"] = map.cmd("BufferLineSortByDirectory"):desc("Buffer: Sort by Dir"),
  ["n|<Leader>bp"] = map.cmd("BufferLinePick"):desc("Buffer: Pick a buffer"),
  ["n|]d"] = map.cmd("BufferLineCycleNext"):desc("Next: Buffer"),
  ["n|[b"] = map.cmd("BufferLineCyclePrev"):desc("Prev: Buffer"),
  ["n|<A-1>"] = map.cmd("BufferLineGoToBuffer 1"):desc("Buffer: Go to 1st visible buffer"),
  ["n|<A-2>"] = map.cmd("BufferLineGoToBuffer 2"):desc("Buffer: Go to 2st visible buffer"),
  ["n|<A-3>"] = map.cmd("BufferLineGoToBuffer 3"):desc("Buffer: Go to 3st visible buffer"),
  ["n|<A-4>"] = map.cmd("BufferLineGoToBuffer 4"):desc("Buffer: Go to 4st visible buffer"),
  ["n|<A-5>"] = map.cmd("BufferLineGoToBuffer 5"):desc("Buffer: Go to 5st visible buffer"),
  ["n|<A-6>"] = map.cmd("BufferLineGoToBuffer 6"):desc("Buffer: Go to 6st visible buffer"),
  ["n|<A-7>"] = map.cmd("BufferLineGoToBuffer 7"):desc("Buffer: Go to 7st visible buffer"),
  ["n|<A-8>"] = map.cmd("BufferLineGoToBuffer 8"):desc("Buffer: Go to 8st visible buffer"),
  ["n|<A-9>"] = map.cmd("BufferLineGoToBuffer 9"):desc("Buffer: Go to 9st visible buffer"),
  ["n|<A-0>"] = map.cmd("BufferLineGoToBuffer 0"):desc("Buffer: Go to last visible buffer"),
  -- Noice
  ["n|<Leader>md"] = map.cmd("Noice dismiss"):desc("Message: Dismiss"),
  ["n|<Leader>ml"] = map.cmd("Noice last"):desc("Message: Show Last"),
  ["n|<Leader>me"] = map.cmd("Noice error"):desc("Message: Show Error"),
  ["n|<Leader>mh"] = map.cmd("Noice history"):desc("Message: Show History"),
}

Keymaps.setup = function()
  map.setup(keymaps_ui)
end

return Keymaps

