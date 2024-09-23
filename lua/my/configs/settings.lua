--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.configs.settings                                             │--
--│  DETAIL: Custome settings often to change are here                       │--
--│  CREATE: 2024-09-19 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Settings = {}
-- Set the dashboard startup image here
-- You can generate the ascii image using: https://github.com/TheZoraiz/ascii-image-converter
-- More info: https://github.com/ayamir/nvimdots/wiki/Issues#change-dashboard-startup-image
---@type string[]
Settings["dashboard_image"] = {
  [[░░░░░░░░░░░░░▓▓░████▄▄▄█▀▄▓▓▓▌█░░░░░░░░░]],
  [[░░░░░░░░░░░░█▌▀▄▓▓▄▄▄▄▀▀▀▄▓▓▓▓▓▌█░░░░░░░]],
  [[░░░░░░░░░░█▀▀▄▓█▓▓▓▓▓▓▓▓▓▓▓▓▀░▓▌█░░░░░░░]],
  [[░░░░░░░░█▀▄▓▓▓███▓▓▓███▓▓▓▄░░▄▐▌█░░░░░░░]],
  [[░░░░░░░░▌▓▓▓▀▀▓▓▓▓███▓▓▓▓▓▓▓▄▀▓▓▐░░░░░░░]],
  [[░░░░░░░█▐██▐░▄▓▓▓▓▓▀▄░▀▓▓▓▓▓▓▓▓▓▌█░░░░░░]],
  [[░░░░░░░▌███▓▓▓▓▓▓▓▓▐░░▄▓▓███▓▓▓▄▀▐░░░░░░]],
  [[░░░░░░█▐█▓▀░░▀▓▓▓▓▓▓▓▓▓██████▓▓▓▓▐░░░░░░]],
  [[░░░░░░▌▓▄▌▀░▀░▐▀█▄▓▓██████████▓▓▓▌█░░░░░]],
  [[░░░░░░▌▓▓▓▄▄▀▀▓▓▓▀▓▓▓▓▓▓▓▓█▓█▓█▓▓▌█░░░░░]],
  [[░░░░░░█▐▓▓▓▓▓▓▄▄▄▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▌█░░░░░]],
}

-- Set the colorscheme to use here.
-- Available values are: `catppuccin`, `catppuccin-latte`, `catppucin-mocha`, `catppuccin-frappe`, `catppuccin-macchiato`.
---@type string
Settings["colorscheme"] = "catppuccin"

-- Set background color to use here.
-- Useful if you would like to use a colorscheme that has a light and dark variant like `edge`.
-- Valid values are: `dark`, `light`.
---@type "dark"|"light"
Settings["background"] = "dark"

-- Set it to true if your terminal has transparent background.
---@type boolean
Settings["transparent_background"] = false

-- Set the command for handling external URLs here. The executable must be available on your $PATH.
-- This entry is IGNORED on Windows and macOS, which have their default handlers builtin.
---@type string
Settings["external_browser"] = "chrome-cli open"

return Settings
