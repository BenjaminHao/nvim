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
  -- Nvim-surround ==> <s> key: surround, acted just like vim motions
  -- Treesitter ==> <cr> - incremental selection, <bs> - decremental
  -- Flash
  ["nxo|m"] = map.func(function() require("flash").jump() end):desc("Motion: Move to"),
  -- Comment
  ["n|<C-c>"] = map.func(_.comment_line):expr():desc("Edit: Comment line(s)"),
  ["n|<C-S-c>"] = map.func(_.comment_block):expr():desc("Edit: Comment block(s)"),
  ["v|<C-c>"] = map.plug("comment_toggle_linewise_visual"):desc("Edit: Comment selected lines"),
  ["v|<C-S-c>"] = map.plug("comment_toggle_blockwise_visual"):desc("Edit: Comment selected blocks"),
  -- TreeSJ
  ["n|<tab>"] = map.cmd("TSJToggle"):desc("Edit: Split/joining Code Block"),
  -- Smart-splits
  ["n|<A-h>"] = map.cmd("SmartCursorMoveLeft"):desc("Window: Focus left"),
  ["n|<A-j>"] = map.cmd("SmartCursorMoveDown"):desc("Window: Focus down"),
  ["n|<A-k>"] = map.cmd("SmartCursorMoveUp"):desc("Window: Focus up"),
  ["n|<A-l>"] = map.cmd("SmartCursorMoveRight"):desc("Window: Focus right"),
  ["n|<A-S-h>"] = map.cmd("SmartSwapLeft"):desc("Window: Move Leftward"),
  ["n|<A-S-j>"] = map.cmd("SmartSwapDown"):desc("Window: Move Downward"),
  ["n|<A-S-k>"] = map.cmd("SmartSwapUp"):desc("Window: Move Upward"),
  ["n|<A-S-l>"] = map.cmd("SmartSwapRight"):desc("Window: Move Rightward"),
  ["n|<A-Left>"] = map.cmd("SmartResizeLeft"):desc("Window: Resize Left"),
  ["n|<A-Down>"] = map.cmd("SmartResizeDown"):desc("Window: Resize Down"),
  ["n|<A-Up>"] = map.cmd("SmartResizeUp"):desc("Window: Resize Up"),
  ["n|<A-Right>"] = map.cmd("SmartResizeRight"):desc("Window: Resize Right"),
}

Keymaps.git_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns
  local keymaps_git = {
    ["n|<Leader>fg"] = map.func(_.find_git):desc("Find: Git"),
    ["n|]h"] = map.func(_.next_hunk):expr():buf(bufnr):desc("Next: Hunk"),
    ["n|[h"] = map.func(_.prev_hunk):expr():buf(bufnr):desc("Prev: Hunk"),
    ["n|<Leader>gs"] = map.func(gs.stage_hunk):buf(bufnr):desc("Git: Stage Hunk"),
    ["v|<Leader>gs"] = map.func(_.stage_hunk_vmode):buf(bufnr):desc("Git: Stage Hunk"),
    ["n|<Leader>gS"] = map.func(gs.stage_buffer):buf(bufnr):desc("Git: Stage Buffer"),
    ["n|<Leader>gu"] = map.func(gs.undo_stage_hunk):buf(bufnr):desc("Git: Undo Stage Hunk"),
    ["n|<Leader>gr"] = map.func(gs.reset_hunk):buf(bufnr):desc("Git: Reset Hunk"),
    ["v|<Leader>gr"] = map.func(_.reset_hunk_vmode):buf(bufnr):desc("Git: Reset Hunk"),
    ["n|<Leader>gR"] = map.func(gs.reset_buffer):buf(bufnr):desc("Git: Reset Buffer"),
    ["n|<Leader>gp"] = map.func(gs.preview_hunk_inline):buf(bufnr):desc("Git: Peek Hunk"),
    ["n|<Leader>gP"] = map.func(gs.preview_hunk):buf(bufnr):desc("Git: Preview Hunk"),
    ["n|<Leader>gb"] = map.func(_.blame_line):buf(bufnr):desc("Git: Blame Line"),
    ["n|<Leader>gd"] = map.func(gs.diffthis):buf(bufnr):desc("Git: Diff This"),
    ["n|<Leader>gD"] = map.func(_.diff_parent):buf(bufnr):desc("Git: Diff Parent"),
    ["n|<Leader>tb"] = map.func(gs.toggle_current_line_blame):buf(bufnr):desc("Toggle: Blame Line"),
    ["n|<Leader>td"] = map.func(gs.toggle_deleted):buf(bufnr):desc("Toggle: Git Deleted"),
  }
  map.setup(keymaps_git)
end

Keymaps.setup = function()
  map.setup(keymaps_editor)
end

return Keymaps
