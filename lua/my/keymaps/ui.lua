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

Keymaps.git_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns
  local keymaps_git = {
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
    ["n|<Leader>Tb"] = map.func(gs.toggle_current_line_blame):buf(bufnr):desc("Toggle: Blame Line"),
    ["n|<Leader>Td"] = map.func(gs.toggle_deleted):buf(bufnr):desc("Toggle: Git Deleted"),
  }
  map.setup(keymaps_git)
end

Keymaps.setup = function()
  map.setup(keymaps_ui)
end

return Keymaps

