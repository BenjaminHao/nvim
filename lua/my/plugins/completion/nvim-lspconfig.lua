--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.completion.nvim-lspconfig                             │--
--│ DESC: LSP config file (npm is required)                                  │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  }
}

Plugin.init = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LSP", { clear = true }),
    callback = function(event)
      local map = require("my.helpers.map")
      local keymaps = {
        ["n|K"] = map.cmd("Lspsaga hover_doc"):buf(event.buf):desc("LSP: Show doc"),
        -- ["n|M"] = map.func(vim.lsp.buf.hover):buf(event.buf):desc("LSP: More info"),
        -- ["n|<C-m>"] = map.func(vim.lsp.buf.signature_help):buf(event.buf):desc("LSP: Signature help"),
        ["n|gd"] = map.cmd("Glance definitions"):buf(event.buf):desc("LSP: Preview definition"),
        -- ["n|gd"] = map.func(f.lsp_goto_definitions):buf(event.buf):desc("LSP: Goto definition"),
        ["n|gD"] = map.cmd("Lspsaga goto_definition"):buf(event.buf):desc("LSP: Goto definition"),
        -- ["n|gD"] = map.func(vim.lsp.buf.declaration):buf(event.buf):desc("LSP: Goto declaration"),
        ["n|gi"] = map.cmd("Glance implementations"):buf(event.buf):desc("LSP: Show Implementations"),
        -- ["n|gi"] = map.func(f.lsp_goto_implementation):buf(event.buf):desc("LSP: Goto implementation"),
          ["n|gr"] = map.cmd("Glance references"):buf(event.buf):desc("LSP: Show references"),
        -- ["n|gr"] = map.func(f.lsp_goto_references):buf(event.buf):desc("LSP: Goto references"),
        -- ["n|<Leader>lt"] = map.func(require("telescope.builtin").lsp_type_definitions):buf(event.buf):desc("LSP: Type definition"),
        -- ["n|<Leader>ls"] = map.func(require("telescope.builtin").lsp_document_symbols):buf(event.buf):desc("LSP: Symbols (current file)"),
        -- ["n|<Leader>lS"] = map.func(require("telescope.builtin").lsp_dynamic_workspace_symbols):buf(event.buf):desc("LSP: Symbols (workspace)"),
        ["n|<Leader>lr"] = map.cmd("Lspsaga rename"):buf(event.buf):desc("LSP: Rename symbol"),
        ["n|<Leader>lR"] = map.cmd("Lspsaga rename ++project"):buf(event.buf):desc("LSP: Rename project symbol"),
        -- ["n|<Leader>lr"] = map.func(vim.lsp.buf.rename):buf(event.buf):desc("LSP: Rename symbol"),
        ["n|<Leader>lc"] = map.cmd("Lspsaga code_action"):buf(event.buf):desc("LSP: Code action"),
        -- ["n|<Leader>lc"] = map.func(vim.lsp.buf.code_action):buf(event.buf):desc("LSP: Code action"),
      }
      map.setup(keymaps)
      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end
      vim.cmd.hi({ "link", "LspReferenceText", "Underlined" })
      vim.cmd.hi({ "link", "LspReferenceRead", "Underlined" })
      vim.cmd.hi({ "link", "LspReferenceWrite", "Underlined" })
    end,
  })
end
-- It's important that you set up the plugins in the following order:
-- 1. mason.nvim
-- 2. mason-lspconfig.nvim
-- 3. Setup servers via nvim-lspconfig
Plugin.config = function()
  local nvim_lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  require("lspconfig.ui.windows").default_options.border = "rounded"

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    virtual_text = true,
    severity_limit = "Hint", -- "Error"|"Warning"|"Information"|"Hint"
    -- set update_in_insert to false because it was enabled by lspsaga
    update_in_insert = false,
  })

  local opts = {
    capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    ),
  }

  ---A handler to setup all servers defined under `completion/servers/*.lua`
  ---@param lsp_name string
  local function mason_lsp_handler(lsp_name)
    -- rust_analyzer is configured using mrcjkb/rustaceanvim
    -- warn users if they have set it up manually
    if lsp_name == "rust_analyzer" then
      local config_exist = pcall(require, "my.plugins.completion.servers." .. lsp_name)
      if config_exist then
        vim.notify(
          [[
`rust_analyzer` is configured independently via `mrcjkb/rustaceanvim`. To get rid of this warning,
please REMOVE your LSP configuration (rust_analyzer.lua) from the `servers` directory and configure
`rust_analyzer` using the appropriate init options provided by `rustaceanvim` instead.]],
          vim.log.levels.WARN,
          { title = "nvim-lspconfig" }
        )
      end
      return
    end

    local ok, custom_handler = pcall(require, "my.plugins.completion.servers." .. lsp_name)
    if not ok then
      -- Default to use factory config for server(s) that doesn't include a spec
      nvim_lspconfig[lsp_name].setup(opts)
      return
    elseif type(custom_handler) == "function" then
      --- Case where language server requires its own setup
      --- Make sure to call require("lspconfig")[lsp_name].setup() in the function
      --- See `clangd.lua` for example.
      custom_handler(opts)
    elseif type(custom_handler) == "table" then
      nvim_lspconfig[lsp_name].setup(vim.tbl_deep_extend("force", opts, custom_handler))
    else
      vim.notify(
        string.format(
          "Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
          lsp_name,
          type(custom_handler)
        ),
        vim.log.levels.ERROR,
        { title = "nvim-lspconfig" }
      )
    end
  end

  mason_lspconfig.setup_handlers({ mason_lsp_handler })
end

return Plugin
