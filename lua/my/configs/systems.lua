--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.configs.systems                                              │--
--│  DETAIL: Configs based on different os                                   │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-13 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Systems = {}
local system = require("my.helpers.system")

local function create_cache_dir()
  local data_dirs = {
    system.cache_dir / "backup",
    system.cache_dir / "session",
    system.cache_dir / "swap",
    system.cache_dir / "tags",
    system.cache_dir / "undo",
  }
  if vim.fn.isdirectory(system.cache_dir) == 0 then
    vim.fn.mkdir(system.cache_dir, "p")
    for _, dir in pairs(data_dirs) do
      if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
      end
    end
  end
end

local function set_clipboard_config()
  if system.is_mac then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
      paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
      cache_enabled = 0,
    }
  elseif system.is_wsl then
    vim.g.clipboard = {
      name = "win32yank-wsl",
      copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
      },
      paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
      },
      cache_enabled = 0,
    }
  end
end

local function set_shell_config()
  if system.is_windows then
    if not (vim.fn.executable("pwsh") == 1 or vim.fn.executable("powershell") == 1) then
      vim.notify(
        [[
Failed to setup terminal config

PowerShell is either not installed, missing from PATH, or not executable;
cmd.exe will be used instead for `:!` (shell bang) and toggleterm.nvim.

You're recommended to install PowerShell for better experience.]],
        vim.log.levels.WARN,
        { title = "[my.configs.systems] Runtime Warning" }
      )
      return
    end

    local basecmd = "-NoLogo -MTA -ExecutionPolicy RemoteSigned"
    local ctrlcmd = "-Command [console]::InputEncoding = [console]::OutputEncoding = [System.Text.Encoding]::UTF8"
    local set_opts = vim.api.nvim_set_option_value
    set_opts("shell", vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell", {})
    set_opts("shellcmdflag", string.format("%s %s;", basecmd, ctrlcmd), {})
    set_opts("shellredir", "-RedirectStandardOutput %s -NoNewWindow -Wait", {})
    set_opts("shellpipe", "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode", {})
    set_opts("shellquote", "", {})
    set_opts("shellxquote", "", {})
  end
end

Systems.setup = function()
  create_cache_dir()
  set_clipboard_config()
  set_shell_config()
end

return Systems
