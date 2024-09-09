local Lua_ls = {}
local system = require("my.helpers.system")

Lua_ls.settings = {
  Lua = {
    diagnostics = {
      globals = { "vim" },
      -- disable = { "different-requires", "undefined-field" },
    },
    workspace = {
      library = {
        [vim.fn.expand("$VIMRUNTIME" / "lua")] = true,
        [vim.fn.expand("$VIMRUNTIME" / "lua" / "vim" / "lsp")] = true,
        [system.config_dir / "lua"] = true,
      },
      maxPreload = 100000,
      preloadFileSize = 10000,
    },
    format = { enable = false },
    telemetry = { enable = false },
    -- Do not override treesitter lua highlighting with lua_ls's highlighting
    semantic = { enable = false },
  }
}
return Lua_ls
