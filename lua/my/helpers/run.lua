--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.helpers.run                                                  │--
--│  DETAIL: Code running                                                    │--
--│  CREATE: github.com/Kicamon/nvim/blob/main/lua/internal/code_running.lua │--
--│  UPDATE: 2024-09-04 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: fix on Windows
local win = require("my.helpers.window")
local api = vim.api
local infos = {}

-- running commands
local config = {
  ["c"] = {
    command = {
      "gcc '$filename' -o '$runfile'",
      "./'$runfile'",
      "rm -f '$runfile'",
    },
  },
  ["cpp"] = {
    command = {
      "g++ '$filename' -std=c++17 -O2 -g -Wall -o '$runfile'",
      "./'$runfile'",
      "rm -rf '$runfile'",
    },
  },
  ["rust"] = {
    command = {
      "rustc '$filename'",
      "./'$runfile'",
      "rm -rf '$runfile'",
    },
  },
  ["python"] = {
    command = "python3 '$filename'",
  },
  ["lua"] = {
    command = "luajit '$filename'",
  },
  ["sh"] = {
    command = "bash '$filename'",
  },
  ["markdown"] = {
    command = "typora '$filename'",
    modus = "job",
  },
}

---get running command and running modus by filetype
---@return table {command: string, modus: string}
local function get_commands()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%")
  local runfile = vim.fn.expand("%<")

  local opt = config[filetype]
  if type(opt.command) == "table" then
    local tmp = ''
    for i, val in ipairs(opt.command) do
      tmp = tmp .. (i ~= 1 and " && " or "") .. val
    end
    opt.command = tmp
  end
  opt.command = string.gsub(opt.command, '$filename', filename)
  opt.command = string.gsub(opt.command, '$runfile', runfile)

  return opt
end

---create float window to running the command
---@param opt table
---@param center boolean
local function running_window(opt, center)
  local float_opt = {
    width = center and 0.8 or -0.25,
    height = center and 0.8 or 0.9,
    relative = "editor",
    title = " Code Running ",
    row = center and "c" or "t",
    col = center and "c" or "r",
  }

  infos.bufnr, infos.winid = win:new_float(float_opt, true, true):wininfo()

  api.nvim_create_autocmd("WinClosed", {
    buffer = infos.bufnr,
    callback = function()
      if infos.winid and api.nvim_win_is_valid(infos.winid) then
        api.nvim_win_close(infos.winid, true)
        api.nvim_buf_delete(infos.bufnr, { force = true })
        infos.winid = nil
      end
    end,
  })

  vim.cmd.term(opt)
end

---quick running code
---@param center boolean
local function running(center)
  vim.cmd('w')

  local workpath = vim.fn.getcwd()

  vim.cmd("silent! lcd %:p:h")

  local opt = get_commands()
  if opt then
    if opt.modus == "job" then
      vim.fn.jobstart(opt.command)
    elseif opt.modus == "cmd" then
      vim.cmd(opt.command)
    else
      running_window(opt.command, center)
    end
  else
    vim.notify("Undefined\n")
  end

  vim.cmd("silent! lcd " .. workpath)
end

return { running = running }
