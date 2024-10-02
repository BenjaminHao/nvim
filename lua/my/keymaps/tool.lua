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
  ["n|<Leader>e"] = map.cmd("NvimTreeToggle"):desc("File Explorer"),
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

Keymaps.nvimtree_on_attach = function(bufnr)
  local api = require "nvim-tree.api"
  local keymaps_nvimtree = {
    ["n|?"] = map.func(api.tree.toggle_help):buf(bufnr):desc("NvimTree: Help"),
    ["n|l"] = map.func(api.node.open.edit):buf(bufnr):desc("NvimTree: Open"),
    ["n|<cr>"] = map.func(api.node.open.edit):buf(bufnr):desc("NvimTree: Open"),
    ["n|<Tab>"] = map.func(api.node.open.preview):buf(bufnr):desc("NvimTree: Open (Preview)"),
    ["n|s"] = map.func(api.node.open.horizontal):buf(bufnr):desc("NvimTree: Open (Horizontal)"),
    ["n|v"] = map.func(api.node.open.vertical):buf(bufnr):desc("NvimTree: Open (Vertical)"),
    ["n|o"] = map.func(api.node.run.system):buf(bufnr):desc("NvimTree: Open (Default App)"),
    ["n|i"] = map.func(api.node.show_info_popup):buf(bufnr):desc("NvimTree: Info"),
    ["n|a"] = map.func(api.fs.create):buf(bufnr):desc("NvimTree: Create"),
    ["n|r"] = map.func(api.fs.rename):buf(bufnr):desc("NvimTree: Rename"),
    ["n|c"] = map.func(api.fs.copy.node):buf(bufnr):desc("NvimTree: Copy"),
    ["n|x"] = map.func(api.fs.cut):buf(bufnr):desc("NvimTree: Cut"),
    ["n|p"] = map.func(api.fs.paste):buf(bufnr):desc("NvimTree: Paste"),
    ["n|d"] = map.func(api.fs.remove):buf(bufnr):desc("NvimTree: Delete"),
    ["n|D"] = map.func(api.fs.trash):buf(bufnr):desc("NvimTree: Trash"),
    ["n|y"] = map.func(api.fs.copy.filename):buf(bufnr):desc("NvimTree: Yank Filename"),  -- or .basename
    ["n|Y"] = map.func(api.fs.copy.absolute_path):buf(bufnr):desc("NvimTree: Yank Absolute Path"),
    ["n|."] = map.func(api.tree.toggle_hidden_filter):buf(bufnr):desc("NvimTree: Toggle Dot Files"),
    ["n|J"] = map.func(api.node.navigate.sibling.last):buf(bufnr):desc("NvimTree: To Last Sibling"),
    ["n|K"] = map.func(api.node.navigate.sibling.first):buf(bufnr):desc("NvimTree: To First Sibling"),
    ["n|h"] = map.func(api.node.navigate.parent):buf(bufnr):desc("NvimTree: To Parent Directory"),
    ["n|H"] = map.func(api.tree.change_root_to_node):buf(bufnr):desc("NvimTree: Set Root Directory"),
    ["n|u"] = map.func(api.tree.change_root_to_parent):buf(bufnr):desc("NvimTree: Show parent root"),
    ["n|q"] = map.func(api.tree.close):buf(bufnr):desc("NvimTree: Close"),
    ["n|<esc>"] = map.func(api.tree.close):buf(bufnr):desc("NvimTree: Close"),
    ["n|R"] = map.func(api.tree.reload):buf(bufnr):desc("NvimTree: Refresh"),
    ["n|b"] = map.func(api.marks.toggle):buf(bufnr):desc("NvimTree: Set Bookmark"),
    ["n|B"] = map.func(api.tree.toggle_no_bookmark_filter):buf(bufnr):desc("NvimTree: Toggle Bookmarks"),
    -- ["n|S"] = map.func(api.tree.search_node):buf(bufnr):desc("NvimTree: Search"), -- this sucks
    -- ["n|t"] = map.func(api.tree.toggle_custom_filter):buf(bufnr):desc("NvimTree: Toggle Custom Filter"),
    -- ["n|e"] = map.func(api.node.run.cmd):buf(bufnr):desc("NvimTree: Execute Command"),
  }
  map.setup(keymaps_nvimtree)
end

Keymaps.setup = function()
  map.setup(keymaps_tool)
end

return Keymaps
