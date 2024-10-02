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
  -- NvimTree
  ["n|<Leader>e"] = map.cmd("Neotree toggle"):desc("File Explorer"),
  ["n|<Leader>E"] = map.cmd("Neotree reveal"):desc("File Explorer Reveal"),
  -- Telescope
  ["n|<Leader>ff"] = map.func(_.find_files):desc("Find: Files"),
  ["n|<Leader>fr"] = map.func(_.find_recent):desc("Find: Recent Files"),
  ["n|<Leader>fw"] = map.func(_.find_word):desc("Find: Word"),
  ["n|<Leader>fn"] = map.func(_.find_configs):desc("Find: Nvim Configs"),
  ["n|<Leader>fh"] = map.cmd("Telescope help_tags"):desc("Find: Help"),
  ["n|<Leader>fp"] = map.cmd("Telescope projects"):desc("Find: Projects"),
  ["n|<Leader>fk"] = map.cmd("Telescope keymaps"):desc("Find: Keymaps"),
  ["n|<Leader>fu"] = map.cmd("Telescope undo"):desc("Find: Undo history"),
  ["n|<Leader>fb"] = map.cmd("Telescope buffers"):desc("Find: Buffers"),
  ["n|<Leader>fm"] = map.cmd("Telescope notify"):desc("Find: Notifications"),
  ["n|<Leader>f<Cr>"] = map.cmd("Telescope resume"):desc("Find: Resume Last"),
  -- Todo-comments
  ["n|<Leader>ft"] = map.cmd("TodoTelescope"):desc("Find: Todo"),
  ["n|]t"] = map.func(_.next_todo):desc("Next: Todo"),
  ["n|[t"] = map.func(_.prev_todo):desc("Prev: Todo"),
  -- nvim-spectre
	["n|<Leader>r"] = map.cmd("Spectre"):desc("Tool: Replace"),
  -- ToggleTerm
  ["n|<C-\\>"] = map.cmd("ToggleTerm direction=horizontal"):desc("Terminal: Toggle Horizontal"),
  ["n|<C-`>"] = map.cmd("ToggleTerm direction=vertical"):desc("Terminal: Toggle Vertical"),
  ["n|<Leader>T"] = map.cmd("ToggleTerm direction=float"):desc("Terminal: Toggle Float"),
  ["n|<leader>G"] = map.func(_.toggle_lazygit):desc("Git: Lazygit"),
}

Keymaps.setup = function()
  map.setup(keymaps_tool)
end

return Keymaps
