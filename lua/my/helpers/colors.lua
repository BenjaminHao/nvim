--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.helpers.color                                                │--
--│  DETAIL: Custom colors                                                   │--
--│  CREATE: nvimdots                                                        │--
--│  UPDATE: 2024-09-13 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Color = {}

---@class palette
---@field rosewater string
---@field flamingo string
---@field mauve string
---@field pink string
---@field red string
---@field maroon string
---@field peach string
---@field yellow string
---@field green string
---@field sapphire string
---@field blue string
---@field sky string
---@field teal string
---@field lavender string
---@field text string
---@field subtext1 string
---@field subtext0 string
---@field overlay2 string
---@field overlay1 string
---@field overlay0 string
---@field surface2 string
---@field surface1 string
---@field surface0 string
---@field base string
---@field mantle string
---@field crust string
---@field none "NONE"

---@type nil|palette
local palette = nil

-- Indicates if autocmd for refreshing the builtin palette has already been registered
---@type boolean
local _has_autocmd = false

---Initialize the palette
---@return palette
local function init_palette()
  -- Reinitialize the palette on event `ColorScheme`
  if not _has_autocmd then
    _has_autocmd = true
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("__builtin_palette", { clear = true }),
      pattern = "*",
      callback = function()
        palette = nil
        init_palette()
        -- Also refresh hard-coded hl groups
        Color.gen_alpha_hl()
        Color.gen_lspkind_hl()
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end

  if not palette then
    palette = vim.g.colors_name:find("catppuccin") and require("catppuccin.palettes").get_palette()
    or {
      rosewater = "#DC8A78",
      flamingo = "#DD7878",
      mauve = "#CBA6F7",
      pink = "#F5C2E7",
      red = "#E95678",
      maroon = "#B33076",
      peach = "#FF8700",
      yellow = "#F7BB3B",
      green = "#AFD700",
      sapphire = "#36D0E0",
      blue = "#61AFEF",
      sky = "#04A5E5",
      teal = "#B5E8E0",
      lavender = "#7287FD",

      text = "#F2F2BF",
      subtext1 = "#BAC2DE",
      subtext0 = "#A6ADC8",
      overlay2 = "#C3BAC6",
      overlay1 = "#988BA2",
      overlay0 = "#6E6B6B",
      surface2 = "#6E6C7E",
      surface1 = "#575268",
      surface0 = "#302D41",

      base = "#1D1536",
      mantle = "#1C1C19",
      crust = "#161320",
    }

    -- palette = vim.tbl_extend("force", { none = "NONE" }, palette, require("core.settings").palette_overwrite)
  end

  return palette
end

---@param c string @The color in hexadecimal.
local function hex_to_rgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

-->If the active colorscheme isn't `catppuccin`, this function won't overwrite existing definitions
---Sets a global highlight group.
---@param name string @Highlight group name, e.g. "ErrorMsg"
---@param foreground string @The foreground color
---@param background? string @The background color
---@param italic? boolean
local function set_global_hl(name, foreground, background, italic)
  vim.api.nvim_set_hl(0, name, {
    fg = foreground,
    bg = background,
    italic = italic == true,
    default = not vim.g.colors_name:find("catppuccin"),
  })
end

---Blend foreground with background
---@param foreground string @The foreground color
---@param background string @The background color to blend with
---@param alpha number|string @Number between 0 and 1 for blending amount.
function Color.blend(foreground, background, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hex_to_rgb(background)
  local fg = hex_to_rgb(foreground)

  local blend_channel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blend_channel(1), blend_channel(2), blend_channel(3))
end

---Get RGB highlight by highlight group
---@param hl_group string @Highlight group name
---@param use_bg boolean @Returns background or not
---@param fallback_hl? string @Fallback value if the hl group is not defined
---@return string
function Color.hl_to_rgb(hl_group, use_bg, fallback_hl)
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

---Extend a highlight group
---@param name string @Target highlight group name
---@param def table @Attributes to be extended
function Color.extend_hl(name, def)
  local hlexists = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if not hlexists then
    -- Do nothing if highlight group not found
    return
  end
  local current_def = vim.api.nvim_get_hl(0, { name = name, link = false })
  local combined_def = vim.tbl_deep_extend("force", current_def, def)

---@diagnostic disable-next-line: param-type-mismatch
  vim.api.nvim_set_hl(0, name, combined_def)
end

---Generate universal highlight groups
---@param overwrite palette? @The color to be overwritten | highest priority
---@return palette
function Color.get_palette(overwrite)
  if not overwrite then
    return vim.deepcopy(init_palette())
  else
    return vim.tbl_extend("force", init_palette(), overwrite)
  end
end

-- Generate highlight groups for lspsaga. Existing attributes will NOT be overwritten
function Color.gen_lspkind_hl()
  local colors = Color.get_palette()
  local data = {
    Class = colors.yellow,
    Constant = colors.peach,
    Constructor = colors.sapphire,
    Enum = colors.yellow,
    EnumMember = colors.teal,
    Event = colors.yellow,
    Field = colors.teal,
    File = colors.rosewater,
    Function = colors.blue,
    Interface = colors.yellow,
    Key = colors.red,
    Method = colors.blue,
    Module = colors.blue,
    Namespace = colors.blue,
    Number = colors.peach,
    Operator = colors.sky,
    Package = colors.blue,
    Property = colors.teal,
    Struct = colors.yellow,
    TypeParameter = colors.blue,
    Variable = colors.peach,
    Array = colors.peach,
    Boolean = colors.peach,
    Null = colors.yellow,
    Object = colors.yellow,
    String = colors.green,
    TypeAlias = colors.green,
    Parameter = colors.blue,
    StaticMethod = colors.peach,
    Text = colors.green,
    Snippet = colors.mauve,
    Folder = colors.blue,
    Unit = colors.green,
    Value = colors.peach,
  }

  for kind, color in pairs(data) do
    set_global_hl("LspKind" .. kind, color)
  end
end

-- Generate highlight groups for alpha. Existing attributes will NOT be overwritten
function Color.gen_alpha_hl()
  local colors = Color.get_palette()

  set_global_hl("AlphaHeader", colors.blue)
  set_global_hl("AlphaButtons", colors.green)
  set_global_hl("AlphaShortcut", colors.pink, nil, true)
  set_global_hl("AlphaFooter", colors.yellow)
end

-- Generate blend_color for neodim.
function Color.gen_neodim_blend_attr()
  local trans_bg = nil
  local appearance = "dark"

  if trans_bg and appearance == "dark" then
    return "#000000"
  elseif trans_bg and appearance == "light" then
    return "#FFFFFF"
  else
    return Color.hl_to_rgb("Normal", true)
  end
end

return Color
