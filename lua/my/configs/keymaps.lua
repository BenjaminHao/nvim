--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.keymaps.builtin                                              │--
--│  DETAIL: Custom keybinds for Neovim                                      │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
--TODO: Migrate keymaps, add toggle
local Keymaps = {}

local util = require("my.helpers.misc")
local map = require("my.helpers.map")
local nvim_keymaps = {
  -- Keep cursor centered
  ["n|J"] = map.key("mzJ`z"):desc("Edit: Join next line"),
  ["n|n"] = map.key("nzzzv"):desc("Edit: Next search result"),
  ["n|N"] = map.key("Nzzzv"):desc("Edit: Prev search result"),
  ["n|<C-d>"] = map.key("<C-d>zz"):desc("Edit: Move screen down half pages"),
  ["n|<C-u>"] = map.key("<C-u>zz"):desc("Edit: Move screen up half pages"),
  ["n|<C-f>"] = map.key("<C-f>zz"):desc("Edit: Move screen down one page"),
  ["n|<C-b>"] = map.key("<C-b>zz"):desc("Edit: Move screen up one page"),
  -- better yanking
  ["v|d"] = map.key('"_d'):desc("Edit: Delete"), -- In visual mode, d for delete, x for cut
  ["n|D"] = map.key("d$"):desc("Edit: Delete text to EOL"),
  ["n|dd"] = map.func(util.better_dd):expr():desc("Edit: Delete line"),
  ["n|x"] = map.key('"_x'):desc("Edit: Delete a character"), -- Do not copy deleted character
  ["n|Y"] = map.key("y$"):desc("Edit: Yank text to EOL"),
  ["v|p"] = map.key('"_dP'):desc("Edit: Paste"), -- Visual overwrite paste
  -- Indenting
  ["v|<"] = map.key("<gv"):desc("Edit: Decrease indent"),
  ["v|>"] = map.key(">gv"):desc("Edit: Increase indent"),
  ["n|i"] = map.func(util.better_insert):expr():desc("Edit: Insert"),
  -- Movement
  ["ic|<C-h>"] = map.key("<Left>"):desc("Edit: Move cursor left"),
  ["ic|<C-j>"] = map.key("<Down>"):desc("Edit: Move cursor down"),
  ["ic|<C-k>"] = map.key("<Up>"):desc("Edit: Move cursor up"),
  ["ic|<C-l>"] = map.key("<Right>"):desc("Edit: Move cursor right"),
  ["ic|<C-a>"] = map.key("<Home>"):desc("Edit: Move cursor to line start"),
  ["ic|<C-e>"] = map.key("<End>"):desc("Edit: Move cursor to line end"),
  ["ic|<C-d>"] = map.key("<Del>"):desc("Edit: Delete"),
  ["i|<C-u>"] = map.key("<C-G>u<C-U>"):desc("Edit: Delete previous block"),
  ["i|<C-,>"] = map.key("<End>,"):desc("Edit: Add comma to line end"),
  ["i|<C-;>"] = map.key("<End>;"):desc("Edit: Add semicolon to line end"),
  ["i|<C-CR>"] = map.key("<End><CR>"):desc("Edit: Start a new line"),
  -- Move Lines
  ["v|J"] = map.key(":m '>+1<CR>gv=gv"):desc("Edit: Move this line down"),
  ["v|K"] = map.key(":m '<-2<CR>gv=gv"):desc("Edit: Move this line up"),
  -- Others
  ["n|<Esc>"] = map.func(util.esc_flash_or_noh):desc("Edit: Clear search highlight"),
  -- ["n|<Esc>"] = map.cmd("nohlsearch"):desc("Edit: Clear search highlight"),
  ["n|<S-Tab>"] = map.cmd("normal za"):desc("Edit: Toggle code fold"),
  ["n|<Leader>w"] = map.cmd("w"):desc("Edit: Write file"),
  ["n|<Leader>q"] = map.cmd("wq"):desc("Edit: Save file and quit"),
  ["n|<Leader>Q"] = map.cmd("q!"):desc("Edit: Force quit"),
  -- ["n|<Leader>ts"] = bind.cmd("setlocal spell! spelllang=en_us"):desc("Edit: Toggle spell check"),
  ["n|<C-t>"] = map.func(function () require("my.helpers.antonym").toggle() end):desc("Edit: Toggle term"),
  ["c|<C-t>"] = map.key([[<C-R>=expand("%:p:h")<CR>]]):desc("Edit: Complete path of current file"),
  --------------------------------- Windows ------------------------------------
  ["n|<C-h>"] = map.key("<C-w>h"):desc("Windows: Focus left"),
  ["n|<C-l>"] = map.key("<C-w>l"):desc("Windows: Focus right"),
  ["n|<C-j>"] = map.key("<C-w>j"):desc("Windows: Focus down"),
  ["n|<C-k>"] = map.key("<C-w>k"):desc("Windows: Focus up"),
  ["n|<A-h>"] = map.cmd("vertical resize -3"):desc("Windows: Resize -3 vertically"),
  ["n|<A-l>"] = map.cmd("vertical resize +3"):desc("Windows: Resize +3 vertically"),
  ["n|<A-j>"] = map.cmd("resize -3"):desc("Windows: Resize -3 horizontally"),
  ["n|<A-k>"] = map.cmd("resize +3"):desc("Windows: Resize +3 horizontally"),
  ------------------------------ Terminal Mode ----------------------------------
  ["t|<C-w>h"] = map.cmd("wincmd h"):desc("Windows: Focus left"),
  ["t|<C-w>l"] = map.cmd("wincmd l"):desc("Windows: Focus right"),
  ["t|<C-w>j"] = map.cmd("wincmd j"):desc("Windows: Focus down"),
  ["t|<C-w>k"] = map.cmd("wincmd k"):desc("Windows: Focus up"),
  ------------------------------ Run Tasks ----------------------------------
  ["n|<F5>"] = map.func(function() require("my.helpers.run").running(false) end),
  ["n|<F10>"] = map.func(function() require("my.helpers.run").running(true) end),
}

local function set_leader_key()
  vim.g.mapleader = " "
end

local function set_neovim_key()
  map.setup(nvim_keymaps)
end

Keymaps.setup = function()
  set_leader_key()
  set_neovim_key()
end

return Keymaps
