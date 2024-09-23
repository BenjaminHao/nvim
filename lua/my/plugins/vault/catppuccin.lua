--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.ui.catppuccin                                        │--
--│  DETAIL: Beautiful colorscheme                                           │--
--│  CREATE: nvimdots                                                        │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "Jint-lzxy/nvim",
  branch = "refactor/syntax-highlighting",
  name = "catppuccin",
  lazy = false, -- do not lazy load colorscheme
  priority = 1000,
}

Plugin.config = function()
  local catppuccin = require("catppuccin")
  local transparent_background = require("my.configs.settings").transparent_background
  local clear = {}

  catppuccin.setup({
    background = { light = "latte", dark = "mocha" }, -- latte, frappe, macchiato, mocha
    dim_inactive = {
      enabled = false,
      -- Dim inactive splits/windows/buffers.
      -- NOT recommended if you use old palette (a.k.a., mocha).
      shade = "dark",
      percentage = 0.15,
    },
    transparent_background = transparent_background,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = true,
    compile_path = vim.fn.stdpath("cache") / "catppuccin",
    styles = {
      comments = { "italic" },
      functions = { "bold" },
      keywords = { "italic" },
      operators = { "bold" },
      conditionals = { "bold" },
      loops = { "bold" },
      booleans = { "bold", "italic" },
      numbers = {},
      types = {},
      strings = {},
      variables = {},
      properties = {},
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      aerial = true,
      alpha = false,
      barbar = false,
      beacon = false,
      cmp = true,
      coc_nvim = false,
      dap = true,
      dap_ui = true,
      dashboard = false,
      dropbar = { enabled = true, color_mode = true },
      fern = false,
      fidget = true,
      flash = true,
      gitgutter = false,
      gitsigns = true,
      harpoon = false,
      headlines = false,
      hop = true,
      illuminate = true,
      indent_blankline = { enabled = true, colored_indent_levels = false },
      leap = false,
      lightspeed = false,
      lsp_saga = true,
      lsp_trouble = true,
      markdown = true,
      mason = true,
      mini = false,
      navic = { enabled = false },
      neogit = false,
      neotest = false,
      neotree = { enabled = false, show_root = true, transparent_panel = false },
      noice = false,
      notify = true,
      nvimtree = true,
      overseer = false,
      pounce = false,
      rainbow_delimiters = true,
      render_markdown = true,
      sandwich = false,
      semantic_tokens = true,
      symbols_outline = false,
      telekasten = false,
      telescope = { enabled = true, style = "nvchad" },
      treesitter_context = true,
      ts_rainbow = false,
      vim_sneak = false,
      vimwiki = false,
      which_key = true,
    },
    color_overrides = {},
    highlight_overrides = {
      ---@param color palette
      all = function(color)
        return {
          -- For base configs
          NormalFloat = { fg = color.text, bg = transparent_background and color.none or color.mantle },
          FloatBorder = {
            fg = transparent_background and color.blue or color.mantle,
            bg = transparent_background and color.none or color.mantle,
          },
          CursorLineNr = { fg = color.green },

          -- For treesitter
          ["@keyword.return"] = { fg = color.pink, style = clear },
          ["@error.c"] = { fg = color.none, style = clear },
          ["@error.cpp"] = { fg = color.none, style = clear },

          -- For native lsp configs
          DiagnosticVirtualTextError = { bg = color.none },
          DiagnosticVirtualTextWarn = { bg = color.none },
          DiagnosticVirtualTextInfo = { bg = color.none },
          DiagnosticVirtualTextHint = { bg = color.none },
          LspInfoBorder = { link = "FloatBorder" },

          -- For mason.nvim
          MasonNormal = { link = "NormalFloat" },

          -- For indent-blankline
          IblIndent = { fg = color.surface0 },
          IblScope = { fg = color.surface2, style = { "bold" } },

          -- For nvim-cmp
          Pmenu = { fg = color.overlay2, bg = transparent_background and color.none or color.base },
          PmenuBorder = { fg = color.surface1, bg = transparent_background and color.none or color.base },
          PmenuSel = { bg = color.green, fg = color.base },
          CmpItemAbbr = { fg = color.overlay2 },
          CmpItemAbbrMatch = { fg = color.blue, style = { "bold" } },
          CmpDoc = { link = "NormalFloat" },
          CmpDocBorder = {
            fg = transparent_background and color.surface1 or color.mantle,
            bg = transparent_background and color.none or color.mantle,
          },

          -- For fidget
          FidgetTask = { bg = color.none, fg = color.surface2 },
          FidgetTitle = { fg = color.blue, style = { "bold" } },

          -- For nvim-notify
          NotifyBackground = { bg = color.base },

          -- For nvim-tree
          NvimTreeRootFolder = { fg = color.pink },
          NvimTreeIndentMarker = { fg = color.surface2 },

          -- For trouble.nvim
          TroubleNormal = { bg = transparent_background and color.none or color.base },
          TroubleNormalNC = { bg = transparent_background and color.none or color.base },

          -- For telescope.nvim
          TelescopeMatching = { fg = color.lavender },
          TelescopeResultsDiffAdd = { fg = color.green },
          TelescopeResultsDiffChange = { fg = color.yellow },
          TelescopeResultsDiffDelete = { fg = color.red },

          -- For glance.nvim
          GlanceWinBarFilename = { fg = color.subtext1, style = { "bold" } },
          GlanceWinBarFilepath = { fg = color.subtext0, style = { "italic" } },
          GlanceWinBarTitle = { fg = color.teal, style = { "bold" } },
          GlanceListCount = { fg = color.lavender },
          GlanceListFilepath = { link = "Comment" },
          GlanceListFilename = { fg = color.blue },
          GlanceListMatch = { fg = color.lavender, style = { "bold" } },
          GlanceFoldIcon = { fg = color.green },
        }
      end,
    },
  })
  vim.cmd.colorscheme("catppuccin")
end

return Plugin
