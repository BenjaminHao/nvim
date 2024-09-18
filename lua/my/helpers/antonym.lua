--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.helpers.antonym                                              │--
--│  DETAIL: Toggle reserve terms                                            │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-13 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Antonym = {}

---@usage Put lower case antonyms here.
local data = {
  ["true"] = "false",
  ["yes"] = "no",
  ["on"] = "off",
  ["left"] = "right",
  ["up"] = "down",
  ["top"] = "bottom",
  ["vertical"] = "horizontal",
  ["before"] = "after",
  ["first"] = "last",
  ["enable"] = "disable",
  ["enabled"] = "disabled",
}

local get_antonym_tbl = function()
  local capitalize = require("my.helpers.utils").capitalize_string
  for key, value in pairs(data) do
    data[value] = key -- add reserve lookup
    if key:find("%a") then
      data[capitalize(key)] = capitalize(value)
      data[key:upper()] = value:upper()
    end
  end
  return data
end

-- TODO: popup window to show tbl
Antonym.check_antonym_tbl = function ()
  vim.print(vim.inspect(get_antonym_tbl()))
end

---Get antonyms.
--  1. Only full lowercase, capitalized, and full uppercase terms supported.
--  2. Normal mode: using <ciw> command.
--  3. Visual mode: using <c> command.
--  Add more terms into data table.
Antonym.toggle = function()
  local terms = get_antonym_tbl()
  local commands = {
    ["n"] = "norm! ciw",
    ["v"] = "norm! c",
  }
  local inverted = vim.tbl_get(terms, vim.fn.expand("<cword>"))
  xpcall(function()
    vim.cmd(vim.tbl_get(commands, vim.api.nvim_get_mode().mode) .. inverted)
  end, function()
      vim.notify(
        [[
This term cannot be inverted.
See more info in "my.helpers.antonym"]],
        vim.log.levels.WARN,
        { title = "[my.helpers.antonym] Runtime Warning" }
      )
    end)
end

--[[
--- TEST FIELD (Default keybind: <Ctrl>t)----
TRUE
True
true
tRue
--]]
return Antonym
