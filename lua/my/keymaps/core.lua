--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.keymaps.core                                                 │--
--│  DETAIL: Keybinds for Neovim builtin stuffs                              │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: add goto file/link keybinds
local Core = {}
local map = require("my.helpers.map")
local _ = require("my.keymaps.func")

-- Make Vim keybinds suck less
local default_override = {
  ["nvo|q"] = map.key("<Esc>"):desc("Quit"), -- Default: Macro, rarely used, map to other keys
  ["n|<S-q>"] = map.cmd("bd"):desc("Quit buffer"), -- Default: Run macro
  ["n|<C-q>"] = map.cmd("close"):desc("Quit Window"), -- Default: V-block mode, same as <C-v>
  ["n|<C-w>"] = map.cmd("w"):desc("Write buffer"), -- Default: Window managemnt, change to <leader>w
  ["n|<S-u>"] = map.key("<C-r>"):desc("Redo"), -- Default: Useless undo mode
  ["n|<`>"] = map.key("m"):desc("Mark"), -- Default: Goto marks, same as <'>
  ["nvo|<C-.>"] = map.key("q"):desc("Macro"), -- Default: Repeat, same as <.>
  -- Additional Motions
  ["nvo|H"] = map.key("^"):desc("Motion: Move to head of line"), -- 0: beginning of line, ^: first non-blank character
  ["nvo|L"] = map.key("g_"):desc("Motion: Move to end of line"), -- $: end of line, g_: last non-blank character
}

local nvim_keymaps = {
  -- Move Lines
  ["v|J"] = map.key(":m '>+1<CR>gv=gv"):desc("Edit: Move line down"),
  ["v|K"] = map.key(":m '<-2<CR>gv=gv"):desc("Edit: Move line up"),
  -- Keep cursor centered
  ["n|J"] = map.key("mzJ`z"):desc("Edit: Join next line"),
  ["n|n"] = map.key("nzzzv"):desc("Edit: Next search result"),
  ["n|N"] = map.key("Nzzzv"):desc("Edit: Prev search result"),
  ["n|<C-d>"] = map.key("<C-d>zz"):desc("Edit: Move screen down half pages"),
  ["n|<C-u>"] = map.key("<C-u>zz"):desc("Edit: Move screen up half pages"),
  ["n|<C-f>"] = map.key("<C-f>zz"):desc("Edit: Move screen down one page"),
  ["n|<C-b>"] = map.key("<C-b>zz"):desc("Edit: Move screen up one page"),
  -- Deleting and yanking
  ["n|D"] = map.key("d$"):desc("Edit: Delete text to EOL"),
  ["n|dd"] = map.func(_.better_dd):expr():desc("Edit: Delete line"),
  ["n|x"] = map.key('"_x'):desc("Edit: Delete a character"),
  ["v|x"] = map.key('"_d'):desc("Edit: Delete"),
  ["n|Y"] = map.key("y$"):desc("Edit: Yank text to EOL"),
  ["v|p"] = map.key('"_dP'):desc("Edit: Paste"), -- Visual overwrite paste
  -- Indenting
  ["v|<"] = map.key("<gv"):desc("Edit: Decrease indent"),
  ["v|>"] = map.key(">gv"):desc("Edit: Increase indent"),
  ["n|i"] = map.func(_.better_insert):expr():desc("Edit: Insert"),
  -- Insert mode
  ["i|<C-q>"] = map.key("<Esc>"):desc("Quit Insert Mode"),
  ["i|<C-v>"] = map.key("<C-r>*"):desc("Edit: Paste"),
  ["i|<C-=>"] = map.key("<C-r>="):desc("Edit: Calculator"),
  ["ic|<C-h>"] = map.key("<Left>"):desc("Edit: Move cursor left"),
  ["ic|<C-j>"] = map.key("<Down>"):desc("Edit: Move cursor down"),
  ["ic|<C-k>"] = map.key("<Up>"):desc("Edit: Move cursor up"),
  ["ic|<C-l>"] = map.key("<Right>"):desc("Edit: Move cursor right"),
  ["ic|<C-a>"] = map.key("<Home>"):desc("Edit: Move cursor to line start"),
  ["ic|<C-e>"] = map.key("<End>"):desc("Edit: Move cursor to line end"),
  ["ic|<C-d>"] = map.key("<Bs>"):desc("Edit: Delete"),
  ["i|<C-u>"] = map.key("<C-G>u<C-U>"):desc("Edit: Delete previous block"),
  ["i|<C-,>"] = map.key("<End>,"):desc("Edit: Add comma to line end"),
  ["i|<C-;>"] = map.key("<End>;"):desc("Edit: Add semicolon to line end"),
  ["i|<C-Cr>"] = map.key("<End><CR>"):desc("Edit: Start a new line"),
  -- Others
  ["n|<C-S-v>"] = map.key("ggVG"):desc("Edit: Select all"),
  ["n|<S-Tab>"] = map.cmd("normal za"):desc("Edit: Toggle code fold"),
  ["n|<Leader>Ts"] = map.cmd("setlocal spell! spelllang=en_us"):desc("Edit: Toggle spell check"),
  ["nv|<C-t>"] = map.func(_.toggle_term):desc("Edit: Toggle term"),
  ["c|<C-t>"] = map.key([[<C-R>=expand("%:p:h")<CR>]]):desc("Edit: Complete path of current file"),
  ---------------------------------- Window -------------------------------------
  -- Override by smart-splits
  ["n|<Leader>w"] = map.key("<C-w>"):desc("Windows"),
  ["n|<C-h>"] = map.key("<C-w>h"):desc("Windows: Focus Left"),
  ["n|<C-l>"] = map.key("<C-w>l"):desc("Windows: Focus Right"),
  ["n|<C-j>"] = map.key("<C-w>j"):desc("Windows: Focus Down"),
  ["n|<C-k>"] = map.key("<C-w>k"):desc("Windows: Focus Up"),
  ["n|<C-S-h>"] = map.key("<C-w>H"):desc("Windows: Move Left"),
  ["n|<C-S-l>"] = map.key("<C-w>L"):desc("Windows: Move Right"),
  ["n|<C-S-j>"] = map.key("<C-w>J"):desc("Windows: Move Down"),
  ["n|<C-S-k>"] = map.key("<C-w>K"):desc("Windows: Move Up"),
  ["n|<C-Left>"] = map.cmd("vertical resize -3"):desc("Windows: Resize -3 vertically"),
  ["n|<C-Down>"] = map.cmd("resize -3"):desc("Windows: Resize -3 horizontally"),
  ["n|<C-Up>"] = map.cmd("resize +3"):desc("Windows: Resize +3 horizontally"),
  ["n|<C-Right>"] = map.cmd("vertical resize +3"):desc("Windows: Resize +3 vertically"),
  ---------------------------------- Buffer -------------------------------------
  ["n|]b"] = map.cmd("bn"):desc("Next: Buffer"),
  ["n|[b"] = map.cmd("bp"):desc("Prev: Buffer"),
  ------------------------------ Terminal Mode ----------------------------------
  ["t|<Esc><Esc>"] = map.key([[<C-\><C-n>]]):desc("Terminal: Normal Mode"),
  ["t|<C-w>h"] = map.cmd("wincmd h"):desc("Windows: Focus left"),
  ["t|<C-w>l"] = map.cmd("wincmd l"):desc("Windows: Focus right"),
  ["t|<C-w>j"] = map.cmd("wincmd j"):desc("Windows: Focus down"),
  ["t|<C-w>k"] = map.cmd("wincmd k"):desc("Windows: Focus up"),
  ------------------------------ Run Tasks ----------------------------------
  -- ["n|<F5>"] = map.func(function() require("my.helpers.run").running(false) end),
  -- ["n|<F10>"] = map.func(function() require("my.helpers.run").running(true) end),
}

local function set_leader_key()
  vim.g.mapleader = " "
end

local function set_neovim_key()
  map.setup(default_override)
  map.setup(nvim_keymaps)
end

Core.setup = function()
  set_leader_key()
  set_neovim_key()
end

return Core
