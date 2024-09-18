--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.keymaps.tool                                                 │--
--│  DETAIL: Keybinds for tool plugins                                       │--
--│  CREATE: 2024-09-16 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-16 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keymaps = {}
local map = require("my.helpers.map")
local _ = require("my.keymaps.func")

local keymaps_tool = {
  -- Lazy
  ["n|<Leader>P"] = map.cmd("Lazy"):desc("Plugin Manager"),
  -- Mason
  ["n|<Leader>L"] = map.cmd("Mason"):desc("LSP Manager"),
  -- NvimTree
  ["n|<Leader>e"] = map.cmd("NvimTreeToggle"):desc("File Explorer"),
  -- Telescope
  ["n|<Leader>ff"] = map.func(_.find_files):desc("Find: Files"),
  ["n|<Leader>fr"] = map.func(_.find_recent):desc("Find: Recent Files"),
  ["n|<Leader>fw"] = map.func(_.find_word):desc("Find: Word"),
  ["n|<Leader>fg"] = map.func(_.find_git):desc("Find: Git"),
  ["n|<Leader>fh"] = map.cmd("Telescope help_tags"):desc("Find: Help"),
  ["n|<Leader>fp"] = map.cmd("Telescope projects"):desc("Find: Projects"),
  ["n|<Leader>fk"] = map.cmd("Telescope keymaps"):desc("Find: Keymaps"),
  ["n|<Leader>fu"] = map.cmd("Telescope undo"):desc("Find: Undo history"),
  ["n|<Leader>fb"] = map.cmd("Telescope buffers"):desc("Find: Buffers"),
  ["n|<Leader>fd"] = map.cmd("Telescope diagnostics"):desc("Find: Diagnostics"),
  ["n|<Leader>ft"] = map.cmd("TodoTelescope"):desc("Find: Todo"),
  ["n|<Leader>fm"] = map.cmd("Telescope notify"):desc("Find: Notifications"),
  ["n|<Leader>f<Cr>"] = map.cmd("Telescope resume"):desc("Find: Resume Last"),
}

Keymaps.setup = function()
  map.setup(keymaps_tool)
end

return Keymaps
