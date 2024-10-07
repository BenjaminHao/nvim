--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.ui.bufferline                                        │--
--│  DETAIL: UI plugin for showing opening buffers                           │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: TODO: config bufferline                                         │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.bufremove",
    "nvim-tree/nvim-web-devicons",
  },
}

Plugin.config = function()
  local bufferline = require("bufferline")
  local bufremove = require("mini.bufremove")

  bufferline.setup({
    options = {
      mode = "buffers",
      themable = true,
      style_preset = bufferline.style_preset.no_italic,
      separator_style = "slant",
      always_show_bufferline = true,
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      left_trunc_marker = "❮",
      right_trunc_marker = "❯",
      indicator = { style = "none" },
      -- TODO: change to relitive numbers when avaliable
      -- numbers = function(_opts)
      --   return string.format("%s", _opts.raise(_opts.ordinal))
      -- end,
      get_element_icon = function(element)
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
        if vim.api.nvim_buf_get_name(0) == element.path then
          return icon, hl
        end
        return icon, "DevIconDimmed"
      end,
      close_command = function(n) bufremove.delete(n, false) end,
      right_mouse_command = function(n) bufremove.delete(n, false) end,
      diagnostics = false, -- OR: | "nvim_lsp" 
      diagnostics_update_in_insert = false,
      sort_by = function(a, b)
        -- sort by modified time (newer to left)
        ---@diagnostic disable-line
        local mod_a = vim.uv.fs_stat(a.path)
        local mod_b = vim.uv.fs_stat(b.path)
        if mod_a == nil and mod_b == nil then
          return a.name > b.name
        elseif mod_a == nil then
          return true
        elseif mod_b == nil then
          return false
        end
        return mod_a.mtime.sec > mod_b.mtime.sec
      end,
      hover = { enabled = true, delay = 30, reveal = { 'close' } },
      offsets = {
        {
          filetype = "NvimTree",
          text = "NvimTree",
          -- text = function()
          --   return vim.fn.fnamemodify(vim.fn.getcwd(), ":~") --(".", ":p:h:t")
          -- end,
          highlight = "BufferLineOffset",
          separator = false, -- use a "true" to enable the default, or set your own character
        },
      },
    },
  })
end

return Plugin
