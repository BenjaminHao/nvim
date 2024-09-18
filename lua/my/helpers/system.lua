--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.helpers.system                                               │--
--│  DETAIL: Utils for checking system and path                              │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local System = {}

local str_mt = getmetatable("") or {}

str_mt.__div = function(lhs, rhs)
  local separator = package.config:sub(1, 1)
  if type(lhs) == "string" and type(rhs) == "string" then
    return lhs .. separator .. rhs
  else
    error("Path separator only works on strings.")
  end
end

if not getmetatable("") then
  debug.setmetatable("", str_mt)
end

local os_name = vim.uv.os_uname().sysname
local home = vim.env.HOME

System.is_mac = os_name == "Darwin"
System.is_linux = os_name == "Linux"
System.is_windows = os_name == "Windows_NT"
System.is_wsl = vim.fn.has("wsl") == 1

-- local home = System.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
System.home_dir = home
System.cache_dir = home / ".cache" / "nvim"
System.data_dir = vim.fn.stdpath("data")
System.config_dir = vim.fn.stdpath("config")
System.plugin_dir = vim.fn.stdpath("config") / "lua" / "my" / "plugins"

return System
