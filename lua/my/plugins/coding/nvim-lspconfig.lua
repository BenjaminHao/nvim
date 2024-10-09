--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.coding.nvim-lspconfig                                │--
--│  DETAIL: Nvim lsp config core plugin (npm is required)                   │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
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

-- It's important that you set up the plugins in the following order:
-- 1. mason.nvim
-- 2. mason-lspconfig.nvim
-- 3. Setup servers via nvim-lspconfig
Plugin.config = function()
  local nvim_lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  require("lspconfig.ui.windows").default_options.border = "rounded"

  -- Change the Diagnostic symbols in the sign column (gutter)
  local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    virtual_text = true,
    severity_limit = "Hint", -- "Error"|"Warning"|"Information"|"Hint"
    update_in_insert = true,
  })

  local opts = {
    capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    ),
  }

  ---A handler to setup all servers defined under `coding/servers/*.lua`
  ---@param lsp_name string
  local function mason_lsp_handler(lsp_name)
    -- rust_analyzer is configured using mrcjkb/rustaceanvim
    -- warn users if they have set it up manually
    if lsp_name == "rust_analyzer" then
      local config_exist = pcall(require, "my.plugins.coding.servers." .. lsp_name)
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

    local ok, custom_handler = pcall(require, "my.plugins.coding.servers." .. lsp_name)
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
          "Failed to setup [%s].\n\nServer definition under `coding/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
          lsp_name,
          type(custom_handler)
        ),
        vim.log.levels.ERROR,
        { title = "nvim-lspconfig" }
      )
    end
  end

  mason_lspconfig.setup_handlers({ mason_lsp_handler })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LSP-attach", { clear = true }),
    callback = function(event_attach)
      require("my.keymaps.coding").lsp_on_attach(event_attach.buf)
      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event_attach.data.client_id)
      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        local highlight_augroup = vim.api.nvim_create_augroup('LSP-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event_attach.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event_attach.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('LSP-detach', { clear = true }),
          callback = function(event_detach)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'LSP-highlight', buffer = event_detach.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        vim.keymap.set("n", "<Leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event_attach.buf })
        end, {
          buffer = event_attach.buf,
          desc = "Toggle: LSP Inlay Hints",
          silent = true,
          noremap = true,
        })
      end
    end,
  })
end

return Plugin
