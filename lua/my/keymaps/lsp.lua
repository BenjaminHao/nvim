--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.keymaps.lsp                                                  │--
--│  DETAIL: Keybinds for lsp related plugins                                │--
--│  CREATE: 2024-09-16 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-16 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keymaps = {}
local map = require("my.helpers.map")
local _ = require("my.keymaps.func")

local keymaps_lsp = {
  -- Mason
  ["n|<Leader>L"] = map.cmd("Mason"):desc("LSP Manager"),
}

-- TODO: change lsp keybinds
Keymaps.lsp_on_attach = function(bufnr)
  local keymaps_lsp_onattach = {
    ["n|]d"] = map.func(vim.diagnostic.goto_next):buf(bufnr):desc("Next: Diagnostic message"),
    ["n|[d"] = map.func(vim.diagnostic.goto_prev):buf(bufnr):desc("Prev: Diagnostic message"),
    ["n|M"] = map.cmd("Lspsaga hover_doc"):buf(bufnr):desc("LSP: Show Doc"),
    ["n|gd"] = map.cmd("Glance definitions"):buf(bufnr):desc("Goto: LSP Definitions"),
    -- ["n|gd"] = map.cmd("Lspsaga goto_definition"):buf(bufnr):desc("Goto: definition"),
    ["n|gD"] = map.func(vim.lsp.buf.declaration):buf(bufnr):desc("Goto: LSP declaration"),
    ["n|<Leader>li"] = map.cmd("Glance implementations"):buf(bufnr):desc("LSP: Show Implementations"),
    -- ["n|<Leader>lr"] = map.cmd("Glance references"):buf(bufnr):desc("LSP: Show References"),
    ["n|<Leader>lr"] = map.cmd("Lspsaga rename"):buf(bufnr):desc("LSP: Rename Symbol"),
    ["n|<Leader>lR"] = map.cmd("Lspsaga rename ++project"):buf(bufnr):desc("LSP: Rename Project symbol"),
    ["n|<Leader>lc"] = map.cmd("Lspsaga code_action"):buf(bufnr):desc("LSP: Code action"),
    ["n|<Leader>lo"] = map.cmd("AerialToggle!"):buf(bufnr):desc("Lsp: Show Outline"),
    ["n|<Leader>fs"] = map.cmd("Telescope aerial"):buf(bufnr):desc("Find: Symbols"),
    -- Trouble TODO:change trouble keybinds
    ["n|gt"] = map.cmd("Trouble diagnostics toggle"):buf(bufnr):desc("Goto: Diagnostics list"),
    ["n|<Leader>lw"] = map.cmd("Trouble diagnostics toggle"):buf(bufnr):desc("LSP: Show workspace diagnostics"),
    ["n|<Leader>lp"] = map.cmd("Trouble project_diagnostics toggle"):buf(bufnr):desc("LSP: Show project diagnostics"),
    ["n|<Leader>ld"] = map.cmd("Trouble diagnostics toggle filter.buf=0"):buf(bufnr):desc("LSP: Show document diagnostics"),
    -- Telescope (lsp related)
    ["n|<Leader>fd"] = map.cmd("Telescope diagnostics"):buf(bufnr):desc("Find: Diagnostics"),
  }
  map.setup(keymaps_lsp_onattach)
end

Keymaps.setup = function()
  map.setup(keymaps_lsp)
end

return Keymaps
