--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.helpers.map                                                  │--
--│  DETAIL: Better readability, for clean key binds                         │--
--│  CREATE: nvimdots                                                        │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Map = {}

---@class map_rhs
---@field cmd string
---@field func function
---@field options table
---@field options.noremap boolean
---@field options.silent boolean
---@field options.expr boolean
---@field options.nowait boolean
---@field options.buffer boolean|number
---@field options.desc string
local map_rhs = {}

function map_rhs:new()
  local instance = {
    cmd = "",
    func = nil,
    options = {
      noremap = true,
      silent = true,
      expr = false,
      nowait = false,
      buffer = false,
      desc = "",
    },
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

---@param keys string
---@return map_rhs
function map_rhs:map_key(keys)
  self.cmd = keys
  return self
end

---@param cmd_string string
---@return map_rhs
function map_rhs:map_cmd(cmd_string)
  self.cmd = ("<Cmd>%s<Cr>"):format(cmd_string)
  return self
end

---@param cmd_string string
--- Clean command. No range selected.
---@return map_rhs
function map_rhs:map_ccmd(cmd_string)
  -- <C-u> to eliminate the automatically inserted range in visual mode
  self.cmd = ("<Cmd><C-u>%s<Cr>"):format(cmd_string)
  return self
end

---@param cmd_string string
---@return map_rhs
function map_rhs:map_args(cmd_string)
  self.cmd = ("<Cmd>%s<Space>"):format(cmd_string)
  return self
end

---@param fun fun():nil
--- Takes a function that will be called when the key is pressed
---@return map_rhs
function map_rhs:map_func(fun)
  self.func = fun
  return self
end

---@return map_rhs
function map_rhs:remap()
  self.options.noremap = false
  return self
end

---@return map_rhs
function map_rhs:echo()
  self.options.silent = false
  return self
end

---@param desc_string string
---@return map_rhs
function map_rhs:desc(desc_string)
  self.options.desc = desc_string
  return self
end

---@return map_rhs
function map_rhs:expr()
  self.options.expr = true
  return self
end

---@return map_rhs
function map_rhs:nowait()
  self.options.nowait = true
  return self
end

---@param num number
---@return map_rhs
function map_rhs:buf(num)
  self.options.buffer = num
  return self
end

---@param cmd_string string
---@return map_rhs
function Map.key(cmd_string)
  local ro = map_rhs:new()
  return ro:map_key(cmd_string)
end

---@param cmd_string string
---@return map_rhs
function Map.cmd(cmd_string)
  local ro = map_rhs:new()
  return ro:map_cmd(cmd_string)
end

---@param cmd_string string
---@return map_rhs
function Map.ccmd(cmd_string)
  local ro = map_rhs:new()
  return ro:map_ccmd(cmd_string)
end

---@param cmd_string string
---@return map_rhs
function Map.args(cmd_string)
  local ro = map_rhs:new()
  return ro:map_args(cmd_string)
end

---@param fun fun():nil
---@return map_rhs
function Map.func(fun)
  local ro = map_rhs:new()
  return ro:map_func(fun)
end

---@param cmd_string string
---@return string escaped_string
function Map.escape_termcode(cmd_string)
  return vim.api.nvim_replace_termcodes(cmd_string, true, true, true)
end

---@param mappings table<string, map_rhs>
function Map.setup(mappings)
  for key, value in pairs(mappings) do
    local modes, keymap = key:match("([^|]*)|?(.*)")
    if type(value) == "table" then
      for _, mode in ipairs(vim.split(modes, "")) do
        local rhs = value.func == nil and value.cmd or value.func
        local options = value.options
        vim.keymap.set(mode, keymap, rhs, options)
      end
    end
  end
end

return Map
