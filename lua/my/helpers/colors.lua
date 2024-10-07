--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.helpers.colors                                               │--
--│  DETAIL: Utils related to colors                                         │--
--│  CREATE: 2024-09-13 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-25 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Colors = {}

---@param hex_str string @The color in hexadecimal
local function hex_to_rgb(hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

  local r, g, b = string.match(hex_str, pat)
  return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---Blend foreground with background
---@param fg_color string @Foreground color
---@param bg_color string @Background color
---@param alpha number|string @Number between 0 and 1 for blending amount. 0 results in bg, 1 results in fg
Colors.blend = function(fg_color, bg_color, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hex_to_rgb(bg_color)
  local fg = hex_to_rgb(fg_color)

  local blend_channel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blend_channel(1), blend_channel(2), blend_channel(3))
end

---@param hex string @The color in hexadecimal
---@param percent number @Percentage of darken, 100 results in black
---@param custom string? @Custom black color to mix (in hexadecimal)
Colors.darken = function(hex, percent, custom)
  return Colors.blend(custom or "#000000", hex, math.abs(percent / 100))
end

---@param hex string @The color in hexadecimal
---@param percent number @Percentage of lighten, 100 results in white
---@param custom string? @Custom white color to mix (in hexadecimal)
Colors.lighten = function(hex, percent, custom)
  return Colors.blend(custom or "#FFFFFF", hex, math.abs(percent / 100))
end

---Get RGB highlight by highlight group
---@param hl_group string @Highlight group name
---@param use_bg boolean @Returns background or not
---@param fallback_hl? string @Fallback value if the hl group is not defined
---@return string
Colors.hl_to_rgb = function(hl_group, use_bg, fallback_hl)
  local hex = fallback_hl or "#000000"
  local hlexists = pcall(vim.api.nvim_get_hl, 0, { name = hl_group, link = false })

  if hlexists then
    local result = vim.api.nvim_get_hl(0, { name = hl_group, link = false })
    if use_bg then
      hex = result.bg and string.format("#%06x", result.bg) or "NONE"
    else
      hex = result.fg and string.format("#%06x", result.fg) or "NONE"
    end
  end

  return hex
end

return Colors
