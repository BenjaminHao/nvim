--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.ui.bufferline                                         │--
--│ DESC: UI plugin for buffers                                              │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    { "echasnovski/mini.bufremove" },
    { "nvim-tree/nvim-web-devicons" },
  },
}

---@param force boolean Force delete buffer
local function delete_buffer(force)
  require("mini.bufremove").delete(0, force)
end

Plugin.init = function()
  local map = require("my.helpers.map")
  local keymaps = {
    ["n|<Leader>bd"] = map.func(function() delete_buffer(true) end):desc("Edit: Delete buffer"),
    ["n|<Leader>bD"] = map.func(function() delete_buffer(true) end):desc("Edit: Force delete buffer"),
    ["n|<Leader>bc"] = map.cmd("BufferLinePickClose"):desc("Edit: Close picked buffer"),
    ["n|<Leader>bC"] = map.cmd("BufferLineCloseOthers"):desc("Edit: Close other buffers"),
    ["n|<Leader>bs"] = map.cmd("BufferLineSortByDirectory"):desc("Edit: Sort buffers"),
    ["n|g1"] = map.cmd("BufferLineGoToBuffer 1"):desc("Edit: Goto buffer 1-9"),
    ["n|g2"] = map.cmd("BufferLineGoToBuffer 2"):desc("which_key_ignore"),
    ["n|g3"] = map.cmd("BufferLineGoToBuffer 3"):desc("which_key_ignore"),
    ["n|g4"] = map.cmd("BufferLineGoToBuffer 4"):desc("which_key_ignore"),
    ["n|g5"] = map.cmd("BufferLineGoToBuffer 5"):desc("which_key_ignore"),
    ["n|g6"] = map.cmd("BufferLineGoToBuffer 6"):desc("which_key_ignore"),
    ["n|g7"] = map.cmd("BufferLineGoToBuffer 7"):desc("which_key_ignore"),
    ["n|g8"] = map.cmd("BufferLineGoToBuffer 8"):desc("which_key_ignore"),
    ["n|g9"] = map.cmd("BufferLineGoToBuffer 9"):desc("which_key_ignore"),
  }
  map.setup(keymaps)
end

Plugin.config = function()
  require("bufferline").setup({
    options = {
      mode = "buffers",
      themable = true,
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      always_show_bufferline = true,
      -- style_preset = bufferline.style_preset.minimal,
      separator_style = "slant",
      numbers = function(opts)
        return string.format("%s", opts.raise(opts.ordinal))
      end,
      get_element_icon = function(element)
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
        return icon, hl
      end,
      close_command = delete_buffer(false),
      diagnostics = false,           -- OR: | "nvim_lsp" 
      diagnostics_update_in_insert = false,
      sort_by = "insert_at_end",
      hover = {
        enabled = true,
        delay = 30,
        reveal = { 'close' }
      },
      offsets = {
        {
          filetype = "NvimTree",
          text = "NvimTree",
          -- text = function()
          --   return vim.fn.fnamemodify(".", ":p:h:t")
          --   -- return vim.fn.getcwd()
          -- end,
          -- highlight = "Directory",
          separator = false, -- use a "true" to enable the default, or set your own character
        },
      },
    },
  })
end

return Plugin
