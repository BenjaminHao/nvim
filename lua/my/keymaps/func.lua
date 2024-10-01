--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.keymaps.func                                                 │--
--│  DETAIL: Functions to be binded (for readability & plugin lazy-loading)  │--
--│  CREATE: 2024-09-16 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-16 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Func = {}
local util = require("my.helpers.utils")

------------------------------------- Core -------------------------------------
Func.better_dd = function()
  return util.is_empty_line() and '"_dd' or "dd"
end

Func.better_insert = function()
  return util.is_empty_line() and "S" or "i"
end

Func.toggle_term = function()
  require("my.helpers.antonym").toggle()
end

-------------------------------------- UI --------------------------------------
Func.delete_buffer = function()
  require("mini.bufremove").delete(0, false)
end

Func.delete_buffer_force = function()
  require("mini.bufremove").delete(0, true)
end

Func.next_hunk = function()
  if vim.wo.diff then return "]h" end
  vim.schedule(function() package.loaded.gitsigns.next_hunk() end)
  return "<Ignore>"
end

Func.prev_hunk = function()
  if vim.wo.diff then return "[h" end
  vim.schedule(function() package.loaded.gitsigns.prev_hunk() end)
  return "<Ignore>"
end

Func.blame_line = function()
  package.loaded.gitsigns.blame_line{ full=true }
end

Func.diff_parent = function()
  package.loaded.gitsigns.diffthis('~')
end

Func.stage_hunk_vmode = function()
  package.loaded.gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')}
end

Func.reset_hunk_vmode = function()
  package.loaded.gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')}
end

------------------------------------ Tools -------------------------------------
Func.find_files = function()
  require("search").open({ collection = "file" })
end

Func.find_recent = function()
  require("search").open({ collection = "recent" })
end

Func.find_word = function()
  require("search").open({ collection = "word" })
end

Func.find_git = function()
  require("search").open({ collection = "git" })
end

Func.find_configs = function()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath 'config',
    prompt_title = 'Nvim Config Files',
  }
end

Func.next_todo = function()
  require("todo-comments").jump_next()
end

Func.prev_todo = function()
  require("todo-comments").jump_prev()
end

local lazygit = nil
Func.toggle_lazygit = function()
  if vim.fn.executable("lazygit") == 1 then
    if not lazygit then
      lazygit = require("toggleterm.terminal").Terminal:new({
        cmd = "lazygit",
        direction = "float",
        close_on_exit = true,
        hidden = true,
      })
    end
    lazygit:toggle()
  else
    vim.notify("Command [lazygit] not found!", vim.log.levels.ERROR, { title = "toggleterm.nvim" })
  end
end

------------------------------------ Editor ------------------------------------
Func.comment_line = function()
  return vim.v.count == 0
    and "<Plug>(comment_toggle_linewise_current)"
    or "<Plug>(comment_toggle_linewise_count)"
end

Func.comment_block = function()
  return vim.v.count == 0
    and "<Plug>(comment_toggle_blockwise_current)"
    or "<Plug>(comment_toggle_blockwise_count)"
end

return Func
