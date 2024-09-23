--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.helpers.hlsearch                                     │--
--│  DETAIL: Auto remove search highlight and rehighlight when using n/N     │--
--│  CREATE: 2024-09-19 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Hlsearch = {}

local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("Hlsearch", { clear = true })
local buffers = {}

local function set_nohlsearch()
  if vim.v.hlsearch == 0 then
    return
  end
  local keycode = vim.api.nvim_replace_termcodes("<Cmd>nohl<CR>", true, false, true)
  vim.api.nvim_feedkeys(keycode, "n", false)
end

local function set_hlsearch()
  local patterns = vim.fn.getreg("/")
  local ok = false
  if vim.v.hlsearch ~= 1 then
      return
  end
  if patterns:find([[%#]], 1, true) then
      set_nohlsearch()
      return
  end
  ok, patterns = pcall(vim.fn.search, [[\%#\zs]] .. patterns, "cnw")
  if ok and patterns == 0 then
    set_nohlsearch()
    return
  end
end

Hlsearch.set_auto_hlsearch = function(bufnr)
  if buffers[bufnr] then
    return
  end
  buffers[bufnr] = true
  local cm_id = autocmd("CursorMoved", {
    desc = "Auto hlsearch",
    group = group,
    buffer = bufnr,
    callback = function()
      set_hlsearch()
    end,
  })

  local ie_id = autocmd("InsertEnter", {
    desc = "Auto nohlsearch",
    group = group,
    buffer = bufnr,
    callback = function()
      set_nohlsearch()
    end,
  })

  autocmd("BufDelete", {
    desc = "Remove auto hlsearch autocmd when deleting buffer",
    buffer = bufnr,
    group = group,
    callback = function(opt)
      buffers[bufnr] = nil
      pcall(vim.api.nvim_del_autocmd, cm_id)
      pcall(vim.api.nvim_del_autocmd, ie_id)
      pcall(vim.api.nvim_del_autocmd, opt.id)
    end,
  })
end

return Hlsearch
