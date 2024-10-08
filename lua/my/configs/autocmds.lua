--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.configs.autocmds                                             │--
--│  DETAIL: QoL autocmd settings                                            │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-13 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Autocmds = {}

local function create_autocmds()
  local autocmd = vim.api.nvim_create_autocmd
  local general = vim.api.nvim_create_augroup("General", { clear = true })

  autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Reload file when it changed",
    group = general,
    callback = function()
      if vim.o.buftype ~= "nofile" then
        vim.cmd("checktime")
      end
    end,
  })

  autocmd("FileType", {
    desc = "Set shiftwidth to 4 in specific filetypes",
    group = general,
    pattern = { "c", "cpp", "py", "java", "cs" },
    callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = true
    end,
  })

  autocmd("BufEnter", {
    desc = "Disable new line comment",
    group = general,
    callback = function()
      vim.opt.formatoptions:remove { "c", "r", "o" }
    end,
  })

  autocmd("FileType", {
    desc = "Close specific buffers with <q> key",
    group = general,
    pattern =
      {
        "lspinfo",
        "man",
        "help",
        "qf",
        "vim",
        "checkhealth",
        "spectre_panel",
      },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", {
        buffer = event.buf,
        noremap = true,
        silent = true,
      })
    end,
  })

  autocmd("BufReadPost", {
    desc = "Go to last location when opening a buffer",
    group = general,
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = general,
    callback = function()
      vim.highlight.on_yank({ higrou = "Visual", timeout = 200 })
    end,
  })

  autocmd("VimEnter", {
    desc = "Open Nvim-Tree when it's a Directory",
    group = general,
    callback = function(data)
      -- buffer is a directory
      local directory = vim.fn.isdirectory(data.file) == 1
      -- change to the directory
      if directory then
        vim.cmd.cd(data.file)
        require("nvim-tree.api").tree.open()
        -- vim.cmd "Telescope find_files"
      end
    end,
  })

  autocmd("VimResized", {
    desc = "Resize splits if window got resized",
    group = general,
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd("tabdo wincmd =")
      vim.cmd("tabnext " .. current_tab)
    end,
  })

  autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
    desc = "Enable relative number in normal mode",
    group = general,
    pattern = "*",
    callback = function()
      if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
        vim.opt.relativenumber = true
      end
    end,
  })

  autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
    desc = "Disable relative number in insert mode",
    group = general,
    pattern = "*",
    callback = function()
      if vim.o.nu then
        vim.opt.relativenumber = false
        vim.cmd("redraw")
      end
    end,
  })

  autocmd("BufEnter", {
    desc = "Auto show/hide hlsearch",
    group = general,
    callback = function(opt)
      require("my.helpers.hlsearch").set_auto_hlsearch(opt.buf)
    end,
  })

end

Autocmds.setup = function()
  create_autocmds()
end

return Autocmds
