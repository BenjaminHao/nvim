--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.keymaps.completion                                           │--
--│  DETAIL: Keybinds for completion plugins                                 │--
--│  CREATE: 2024-09-16 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-16 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Keymaps = {}
local map = require("my.helpers.map")
local _ = require("my.keymaps.func")

local keymaps_completion = {

}

Keymaps.lsp_on_attach = function(bufnr)
  local keymaps_lsp = {
    ["n|]d"] = map.func(vim.diagnostic.goto_next):buf(bufnr):desc("Next: Diagnostic message"),
    ["n|[d"] = map.func(vim.diagnostic.goto_prev):buf(bufnr):desc("Prev: Diagnostic message"),
    ["n|K"] = map.cmd("Lspsaga hover_doc"):buf(bufnr):desc("LSP: Show Doc"),
    ["n|gd"] = map.cmd("Lspsaga goto_definition"):buf(bufnr):desc("Goto: definition"),
    ["n|gD"] = map.func(vim.lsp.buf.declaration):buf(bufnr):desc("LSP: Goto declaration"),
    ["n|<Leader>ld"] = map.cmd("Glance definitions"):buf(bufnr):desc("LSP: Preview Definition"),
    ["n|<Leader>li"] = map.cmd("Glance implementations"):buf(bufnr):desc("LSP: Show Implementations"),
    -- ["n|<Leader>lr"] = map.cmd("Glance references"):buf(bufnr):desc("LSP: Show References"),
    ["n|<Leader>lr"] = map.cmd("Lspsaga rename"):buf(bufnr):desc("LSP: Rename Symbol"),
    ["n|<Leader>lR"] = map.cmd("Lspsaga rename ++project"):buf(bufnr):desc("LSP: Rename Project symbol"),
    ["n|<Leader>lc"] = map.cmd("Lspsaga code_action"):buf(bufnr):desc("LSP: Code action"),
  }
  map.setup(keymaps_lsp)
end

Keymaps.setup = function()
  map.setup(keymaps_completion)
end

return Keymaps
