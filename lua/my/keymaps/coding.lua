--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.keymaps.coding                                               │--
--│  DETAIL: Keybinds for coding related plugins                             │--
--│  CREATE: 2024-09-16 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-16 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keymaps = {}
local map = require("my.helpers.map")
local _ = require("my.keymaps.func")

local keymaps_coding = {
  -- Mason
  ["n|<Leader>L"] = map.cmd("Mason"):desc("LSP Manager"),
  -- Conform
  ["nv|<C-=>"] = map.func(_.format_file_or_selected):desc("Format Code"),
  ["n|<Leader>tf"] = map.cmd("FormatToggle"):desc("Toggle: Format (Global)"),
  ["n|<Leader>tF"] = map.cmd("FormatToggle!"):desc("Toggle: Format (Buffer)")
}

-- TODO: change lsp keybinds
Keymaps.lsp_on_attach = function(bufnr)
  local keymaps_lsp = {
    ["n|]d"] = map.func(vim.diagnostic.goto_next):buf(bufnr):desc("Next: Diagnostic message"),
    ["n|[d"] = map.func(vim.diagnostic.goto_prev):buf(bufnr):desc("Prev: Diagnostic message"),
    ["n|gd"] = map.cmd("Glance definitions"):buf(bufnr):desc("Goto: LSP Definitions"),
    ["n|gD"] = map.func(vim.lsp.buf.declaration):buf(bufnr):desc("Goto: LSP declaration"),
    ["n|gr"] = map.cmd("Glance references"):buf(bufnr):desc("Goto: LSP References"),
    ["n|<Leader>li"] = map.cmd("Glance implementations"):buf(bufnr):desc("LSP: Show Implementations"),
    ["n|<Leader>lt"] = map.cmd("Glance type_definition"):buf(bufnr):desc("LSP: Show Type Definitions"),
    ["n|<Leader>lr"] = map.func(vim.lsp.buf.rename):buf(bufnr):desc("LSP: Rename Symbol"),
    ["n|<Leader>la"] = map.func(vim.lsp.buf.code_action):buf(bufnr):desc("LSP: Code Action"),
    ["n|<Leader>lo"] = map.cmd("AerialToggle!"):buf(bufnr):desc("Lsp: Show Outline"),
    -- Trouble TODO: change trouble keybinds
    ["n|gt"] = map.cmd("Trouble diagnostics toggle"):buf(bufnr):desc("Goto: Diagnostics list"),
    ["n|<Leader>lw"] = map.cmd("Trouble diagnostics toggle"):buf(bufnr):desc("LSP: Show workspace diagnostics"),
    ["n|<Leader>lp"] = map.cmd("Trouble project_diagnostics toggle"):buf(bufnr):desc("LSP: Show project diagnostics"),
    ["n|<Leader>ld"] = map.cmd("Trouble diagnostics toggle filter.buf=0"):buf(bufnr):desc("LSP: Show document diagnostics"),
    -- Telescope (lsp related)
    ["n|<Leader>fs"] = map.cmd("Telescope aerial"):buf(bufnr):desc("Find: Symbols"),
    ["n|<Leader>fd"] = map.cmd("Telescope diagnostics"):buf(bufnr):desc("Find: Diagnostics"),
  }
  map.setup(keymaps_lsp)
end

Keymaps.setup = function()
  map.setup(keymaps_coding)
end

return Keymaps
