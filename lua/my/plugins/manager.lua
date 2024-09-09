--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.manager                                              │--
--│  DETAIL: Lazy.nvim as plugin manager                                     │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Manager = {}

local system = require("my.helpers.system")

local function bootstrap_lazy()
  local lazy_repo = "https://github.com/folke/lazy.nvim.git"
  local lazy_path = system.data_dir / "lazy" / "lazy.nvim"

  if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    local out = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      lazy_repo,
      lazy_path,
    })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazy_path)
end

local function setup_lazy()
  local lazy_config = {
    root = system.data_dir / "lazy",
    lockfile = system.config_dir / "lazy-lock.json",
    confurrency = system.is_mac and 20 or nil,
    defaults = {
      lazy = true,
    },
    install = {
      colorscheme = { "catppuccin" },
    },
    spec = {
      { import = "my.plugins.ui" },
      { import = "my.plugins.tool" },
      { import = "my.plugins.editor" },
      { import = "my.plugins.completion" },
    },
    checker = {
      notify = false,
    },
    change_detection = {
      notify = false,
    },
    ui = {
      border = "shadow",
    },
    performance = {
      cache = {
        enabled = true,
        path = system.cache_dir / "lazy" / "cache",
        -- Once one of the following events triggers, caching will be disabled.
        -- To cache all modules, set this to `{}`, but that is not recommended.
        disable_events = { "UIEnter", "BufReadPre" },
        ttl = 3600 * 24 * 2, -- keep unused modules for up to 2 days
      },
      rtp = {
        -- Disable default plugins
        disabled_plugins = {
          "2html_plugin",
          "tohtml",
          "getscript",
          "getscriptPlugin",
          "gzip",
          "logipat",
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "matchit",
          "tar",
          "tarPlugin",
          "rrhelper",
          "spellfile_plugin",
          "vimball",
          "vimballPlugin",
          "zip",
          "zipPlugin",
          "tutor",
          "rplugin",
          "syntax",
          "synmenu",
          "optwin",
          "compiler",
          "bugreport",
          "ftplugin",
        },
      },
    },
  }
  require("lazy").setup(lazy_config)
end

Manager.setup = function()
  bootstrap_lazy()
  setup_lazy()
end

return Manager
