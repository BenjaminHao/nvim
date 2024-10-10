--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.keymaps.core                                                 │--
--│  DETAIL: Keybinds for Neovim builtin stuffs                              │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: add goto file/link/plugin-repo keybinds
local Core = {}
local _ = require("my.keymaps.func")
local map = require("my.helpers.map")

local nvim_keymaps = {
  ["nvo|gh"] = map.key("^"):desc("Goto: First non-blank character"),
  ["nvo|gl"] = map.key("g_"):desc("Goto: Last non-blank character"),
  -- Move Lines
  ["n|<C-h>"] = map.key("<<"):desc("Edit: Decrease indent"),
  ["n|<C-l>"] = map.key(">>"):desc("Edit: Increase indent"),
  ["v|<C-h>"] = map.key("<gv"):desc("Edit: Decrease indent"),
  ["v|<C-l>"] = map.key(">gv"):desc("Edit: Increase indent"),
  ["n|<C-j>"] = map.key(":m .+1<CR>=="):desc("Edit: Move line down"),
  ["n|<C-k>"] = map.key(":m .-2<CR>=="):desc("Edit: Move line up"),
  ["v|<C-j>"] = map.key(":m '>+1<CR>gv=gv"):desc("Edit: Move line down"),
  ["v|<C-k>"] = map.key(":m '<-2<CR>gv=gv"):desc("Edit: Move line up"),
  -- Keep cursor centered
  ["n|J"] = map.key("mzJ`z"):desc("Edit: Join next line"),
  ["n|n"] = map.key("nzzzv"):desc("Edit: Next search result"),
  ["n|N"] = map.key("Nzzzv"):desc("Edit: Prev search result"),
  ["n|<C-d>"] = map.key("<C-d>zz"):desc("Edit: Scroll screen down half pages"),
  ["n|<C-u>"] = map.key("<C-u>zz"):desc("Edit: Scroll screen up half pages"),
  ["n|<C-f>"] = map.key("<C-f>zz"):desc("Edit: Scroll screen down one page"),
  ["n|<C-b>"] = map.key("<C-b>zz"):desc("Edit: Scroll screen up one page"),
  -- Deleting, yanking and changing
  ["n|D"] = map.key("d$"):desc("Edit: Delete text to EOL"),
  ["n|dd"] = map.func(_.better_dd):expr():desc("Edit: Delete line"),
  ["v|d"] = map.key('"_d'):desc("Edit: Delete"), -- d: delete, x: cut
  ["n|x"] = map.key('"_x'):desc("Edit: Delete a character"),
  ["n|Y"] = map.key("y$"):desc("Edit: Yank text to end of line"),
  ["v|p"] = map.key('"_dP'):desc("Edit: Paste"), -- Visual overwrite paste
  ["nv|c"] = map.key('"_c'):desc("Edit: Change"),
  ["nv|C"] = map.key('"_C'):desc("Edit: Change to end of line"),
  -- Insert mode
  ["n|i"] = map.func(_.better_insert):expr():desc("Edit: Insert"),
  -- ["i|<C-Space>"] = map.key("<Esc>"):desc("Quit Insert Mode"),
  ["i|<C-=>"] = map.key("<C-r>="):desc("Edit: Calculator"),
  ["ic|<C-v>"] = map.key("<C-r>*"):desc("Edit: Paste"),
  ["ic|<C-h>"] = map.key("<Left>"):desc("Motion: Move cursor left"),
  ["ic|<C-j>"] = map.key("<Down>"):desc("Motion: Move cursor down"),
  ["ic|<C-k>"] = map.key("<Up>"):desc("Motion: Move cursor up"),
  ["ic|<C-l>"] = map.key("<Right>"):desc("Motion: Move cursor right"),
  ["ic|<C-S-h>"] = map.key("<Home>"):desc("Motion: Move cursor to beginning of line"),
  ["ic|<C-S-j>"] = map.key("<C-End>"):desc("Motion: Move cursor to end of file"),
  ["ic|<C-S-k>"] = map.key("<C-Home>"):desc("Motion: Move cursor to beginning of file"),
  ["ic|<C-S-l>"] = map.key("<End>"):desc("Motion: Move cursor to end of line"),
  ["ic|<C-a>"] = map.key("<Home>"):desc("Motion: Move cursor to beginning of line"),
  ["ic|<C-e>"] = map.key("<End>"):desc("Motion: Move cursor to end of line"),
  ["i|<C-d>"] = map.key("<C-G>u<C-U>"):desc("Edit: Delete previous block"),
  ["i|<C-,>"] = map.key("<End>,"):desc("Edit: Add a comma to end of line"),
  ["i|<C-;>"] = map.key("<End>;"):desc("Edit: Add a semicolon to end of line"),
  ["i|<C-Cr>"] = map.key("<End><CR>"):desc("Edit: Start a new line"),
  -- Others
  ["n|U"] = map.key("<C-r>"):desc("Redo"), -- Default: Useless undo mode
  ["niv|<C-s>"] = map.cmd("w"):desc("Save"), -- Default: Freeze screen, useless
  ["n|`"] = map.key("m"):desc("Mark"), -- Default: Goto marks, same as <'>
  ["n|<C-S-v>"] = map.key("ggVG"):desc("Edit: Select all"),
  ["n|<S-Tab>"] = map.cmd("normal za"):desc("Edit: Toggle code fold"),
  ["n|<Leader>ts"] = map.cmd("setlocal spell! spelllang=en_us"):desc("Toggle: Spell Check"),
  ["nv|<C-t>"] = map.func(_.toggle_term):desc("Edit: Toggle term"),
  ["c|<C-t>"] = map.key([[<C-R>=expand("%:p:h")<CR>]]):desc("Edit: Complete path of current file"),
  ---------------------------------- Window -------------------------------------
  -- TODO: find vim api for this
  ["n|<A-d>"] = map.key("<C-w>p<C-d><C-w>p"):desc("Windows: Scroll last window down half pages"),
  ["n|<A-u>"] = map.key("<C-w>p<C-u><C-w>p"):desc("Windows: Scroll last window up half pages"),
  ["n|<A-f>"] = map.key("<C-w>p<C-f><C-w>p"):desc("Windows: Scroll last window down one page"),
  ["n|<A-b>"] = map.key("<C-w>p<C-b><C-w>p"):desc("Windows: Scroll last window up one page"),
  ["i|<A-d>"] = map.key("<Esc><C-w>p<C-d><C-w>pa"):desc("Windows: Scroll last window down half pages"),
  ["i|<A-u>"] = map.key("<Esc><C-w>p<C-u><C-w>pa"):desc("Windows: Scroll last window up half pages"),
  ["i|<A-f>"] = map.key("<Esc><C-w>p<C-f><C-w>pa"):desc("Windows: Scroll last window down one page"),
  ["i|<A-b>"] = map.key("<Esc><C-w>p<C-b><C-w>pa"):desc("Windows: Scroll last window up one page"),
  -- Override by smart-splits
  ["n|<A-h>"] = map.key("<C-w>h"):desc("Windows: Focus Left"),
  ["n|<A-j>"] = map.key("<C-w>j"):desc("Windows: Focus Down"),
  ["n|<A-k>"] = map.key("<C-w>k"):desc("Windows: Focus Up"),
  ["n|<A-l>"] = map.key("<C-w>l"):desc("Windows: Focus Right"),
  ["n|<A-S-h>"] = map.key("<C-w>H"):desc("Windows: Move Left"),
  ["n|<A-S-j>"] = map.key("<C-w>J"):desc("Windows: Move Down"),
  ["n|<A-S-k>"] = map.key("<C-w>K"):desc("Windows: Move Up"),
  ["n|<A-S-l>"] = map.key("<C-w>L"):desc("Windows: Move Right"),
  ["n|<Left>"] = map.cmd("vertical resize -3"):desc("Windows: Resize -3 vertically"),
  ["n|<Down>"] = map.cmd("resize -3"):desc("Windows: Resize -3 horizontally"),
  ["n|<Up>"] = map.cmd("resize +3"):desc("Windows: Resize +3 horizontally"),
  ["n|<Right>"] = map.cmd("vertical resize +3"):desc("Windows: Resize +3 vertically"),
  ---------------------------------- Buffer -------------------------------------
  ["n|]b"] = map.cmd("bn"):desc("Next: Buffer"),
  ["n|[b"] = map.cmd("bp"):desc("Prev: Buffer"),
  ["n|<Leader>bn"] = map.cmd("enew"):desc("Buffer: New Buffer"),
  ------------------------------ Terminal Mode ----------------------------------
  ["t|<Esc><Esc>"] = map.key([[<C-\><C-n>]]):desc("Terminal: Normal Mode"),
  ["t|<A-h>"] = map.cmd("wincmd h"):desc("Windows: Focus left"),
  ["t|<A-j>"] = map.cmd("wincmd j"):desc("Windows: Focus down"),
  ["t|<A-k>"] = map.cmd("wincmd k"):desc("Windows: Focus up"),
  ["t|<A-l>"] = map.cmd("wincmd l"):desc("Windows: Focus right"),
}

local function set_leader_key()
  vim.g.mapleader = " "
end

local function set_neovim_key()
  map.setup(nvim_keymaps)
end

Core.setup = function()
  set_leader_key()
  set_neovim_key()
end

return Core
