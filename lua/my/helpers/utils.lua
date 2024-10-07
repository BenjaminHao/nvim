--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.helpers.utils                                                │--
--│  DETAIL: Reusable utils functions                                        │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-13 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Utils = {}

Utils.is_empty_line = function()
  local current_line = vim.api.nvim_get_current_line()
  return current_line:match('^%s*$') ~= nil
end

Utils.capitalize_string = function(str)
  return (str:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper()..rest
  end, 1))
end

---Generate a new table that contains its capitalized & full uppercase form data
---@param tbl table @The list like table to convert
---@return table @Returns table that contains different forms
Utils.get_diff_case_tbl = function (tbl)
  local new_tbl = {}
  if not vim.islist(tbl) then
    vim.notify(
      "Attempting to convert data of type '" .. type(tbl) .. "' to list like table",
      vim.log.levels.ERROR,
      { title = "[my.helpers.utils] Runtime Error" }
    )
  end
  for _, str in ipairs(tbl) do
    table.insert(new_tbl, str)
    if str:find("%a") then
      table.insert(new_tbl, Utils.capitalize_string(str))
      table.insert(new_tbl, str:upper())
    end
  end
  return new_tbl
end

---Convert number (0/1) to boolean
---@param value number @The value to check
---@return boolean|nil @Returns nil if failed
Utils.tobool = function(value)
  if value == 0 then
    return false
  elseif value == 1 then
    return true
  else
    vim.notify(
      "Attempting to convert data of type '" .. type(value) .. "' [other than 0 or 1] to boolean",
      vim.log.levels.ERROR,
      { title = "[my.helpers.utils] Runtime Error" }
    )
    return nil
  end
end

---Get modules list under the path
---@param path string Path string starting with "my/"
---@return table Returns a table contains modules list in that path (in . form)
---@usage get_modules_in_dir("my/plugins") will get a table contains lua modules in my/plugins dir.
Utils.get_modules_in_dir = function(path)
  local module_list = {}
  local prefix = path:gsub("/", ".") .. "."
  local file_list = vim.split(
    vim.fn.glob(vim.fn.stdpath("config") .. "/lua/" .. path .. "/*.lua"),
    "\n"
  )
  for _, file in ipairs(file_list) do
    table.insert(module_list, prefix .. vim.fn.fnamemodify(file, ":t"):sub(0, -5))
  end

  return module_list
end

Utils.set_colorborder = function(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

Utils.command_panel = function()
  require("telescope.builtin").keymaps({
    lhs_filter = function(lhs)
      return not string.find(lhs, "Þ")
    end,
    layout_config = {
      width = 0.6,
      height = 0.6,
      prompt_position = "top",
    },
  })
end

Utils.telescope_reveal_in_nvimtree = function()
  local selection = require("telescope.actions.state").get_selected_entry()
  local file_path = selection.path
  if file_path == nil then
    file_path = selection[1]
  end
  require('neo-tree.command').execute {
    action = 'focus', -- OPTIONAL, this is the default value
    source = 'filesystem', -- OPTIONAL, this is the default value
    position = 'left', -- OPTIONAL, this is the default value
    reveal_file = file_path, -- path to file or folder to reveal
    reveal_force_cwd = true, -- change cwd without asking if needed
  }
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
end

return Utils
