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
    color_overrides = {
      all = {
        dark_purple = "#c7a0dc",
        sun = "#ffe9b6",
        vibrant_green = "#b6f4be",
      },
    },
    highlight_overrides = {
      all = function(color)
        return {
          -- For base configs
          NormalFloat = { fg = color.text, bg = transparent_background and color.none or color.mantle },
          FloatBorder = {
            fg = transparent_background and color.blue or color.mantle,
            bg = transparent_background and color.none or color.mantle,
          },
          CursorLineNr = { fg = color.green },

          -- nvim status bar
          StatusLine = { bg = color.base },

          -- For treesitter
          ["@variable"] = { link = "Variable" },
          ["@keyword.return"] = { fg = color.pink, style = clear },
          ["@error.c"] = { fg = color.none, style = clear },
          ["@error.cpp"] = { fg = color.none, style = clear },

          -- nvim-web-devicons
          DevIconDefault = { fg = color.red },
          DevIconc = { fg = color.blue },
          DevIconcss = { fg = color.blue },
          DevIcondeb = { fg = color.teal },
          DevIconDockerfile = { fg = color.teal },
          DevIconhtml = { fg = color.maroon },
          DevIconjpeg = { fg = color.dark_purple },
          DevIconjpg = { fg = color.dark_purple },
          DevIconjs = { fg = color.sun },
          DevIconkt = { fg = color.peach },
          DevIconlock = { fg = color.red },
          DevIconlua = { fg = color.blue },
          DevIconmp3 = { fg = color.text },
          DevIconmp4 = { fg = color.text },
          DevIconout = { fg = color.text },
          DevIconpng = { fg = color.dark_purple },
          DevIconpy = { fg = color.teal },
          DevIcontoml = { fg = color.blue },
          DevIconts = { fg = color.teal },
          DevIconttf = { fg = color.text },
          DevIconrb = { fg = color.pink },
          DevIconrpm = { fg = color.peach },
          DevIconvue = { fg = color.vibrant_green },
          DevIconwoff = { fg = color.text },
          DevIconwoff2 = { fg = color.text },
          DevIconxz = { fg = color.sun },
          DevIconzip = { fg = color.sun },
          DevIconZig = { fg = color.peach },
          DevIconMd = { fg = color.blue },
          DevIconTSX = { fg = color.blue },
          DevIconJSX = { fg = color.blue },
          DevIconSvelte = { fg = color.red },
          DevIconJava = { fg = color.peach },
          DevIconDart = { fg = color.teal },

          -- For native lsp configs
          DiagnosticVirtualTextError = { bg = color.none },
          DiagnosticVirtualTextWarn = { bg = color.none },
          DiagnosticVirtualTextInfo = { bg = color.none },
          DiagnosticVirtualTextHint = { bg = color.none },
          LspInfoBorder = { link = "FloatBorder" },

          -- For mason.nvim
          MasonNormal = { link = "NormalFloat" },

          -- Bufferline.nvim
          BufferLineOffset = { bg = color.mantle, fg = color.lavender },
          DevIconDimmed = { fg = color.surface1 },

          -- For indent-blankline
          IblIndent = { fg = color.surface0 },
          IblScope = { fg = color.surface2, style = { "bold" } },

          -- Flash
          FlashPrompt = { link = "Normal" },
          FlashPromptMode = { bg = "NONE", fg = color.yellow },

          -- For nvim-cmp
          CmpItemKindSnippet = { bg = color.mauve, fg = color.base},
          CmpItemKindKeyword = { bg = color.red, fg = color.base},
          CmpItemKindText = { bg = color.teal, fg = color.base},
          CmpItemKindMethod = { bg = color.blue, fg = color.base},
          CmpItemKindConstructor = { bg = color.blue, fg = color.base},
          CmpItemKindFunction = { bg = color.blue, fg = color.base},
          CmpItemKindFolder = { bg = color.blue, fg = color.base},
          CmpItemKindModule = { bg = color.blue, fg = color.base},
          CmpItemKindConstant = { bg = color.peach, fg = color.base},
          CmpItemKindField = { bg = color.green, fg = color.base},
          CmpItemKindProperty = { bg = color.green, fg = color.base},
          CmpItemKindEnum = { bg = color.green, fg = color.base},
          CmpItemKindUnit = { bg = color.green, fg = color.base},
          CmpItemKindClass = { bg = color.yellow, fg = color.base},
          CmpItemKindVariable = { bg = color.flamingo, fg = color.base},
          CmpItemKindFile = { bg = color.blue, fg = color.base},
          CmpItemKindInterface = { bg = color.yellow, fg = color.base},
          CmpItemKindColor = { bg = color.red, fg = color.base},
          CmpItemKindReference = { bg = color.red, fg = color.base},
          CmpItemKindEnumMember = { bg = color.red, fg = color.base},
          CmpItemKindStruct = { bg = color.blue, fg = color.base},
          CmpItemKindValue = { bg = color.peach, fg = color.base},
          CmpItemKindEvent = { bg = color.blue, fg = color.base},
          CmpItemKindOperator = { bg = color.blue, fg = color.base},
          CmpItemKindTypeParameter = { bg = color.blue, fg = color.base},
          CmpItemKindCopilot = { bg = color.teal, fg = color.base},
          PmenuSel = { bg = color.green, fg = color.base },
          PmenuBorder = { fg = color.surface1, bg = transparent_background and color.none or color.base },
          CmpItemAbbr = { fg = color.text },
          CmpItemAbbrMatch = { fg = color.blue, bold = true },
          CmpSel = { link = "PmenuSel", bold = true },
          CmpPmenu = { bg = color.mantle },
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
          -- NvimTreeRootFolder = { fg = color.pink },
          NvimTreeNormal = { bg = color.base },
          NvimTreeWinSeparator = { fg = color.mantle, bg = color.none },
          NvimTreeEmptyFolderName = { fg = color.text },
          NvimTreeExecFile = { fg = color.text },
          NvimTreeFolderIcon = { fg = color.blue },
          NvimTreeFolderName = { fg = color.text },
          NvimTreeImageFile = { fg = color.text },
          NvimTreeIndentMarker = { fg = color.surface1 },
          NvimTreeOpenedFolderName = { fg = color.text },
          NvimTreeSymlink = { fg = color.text },
          NvimTreeGitDeleted = { fg = color.red },
          NvimTreeGitDirty = { fg = color.peach },
          NvimTreeGitIgnored = { fg = color.surface1_fg },
          NvimTreeGitNew = { fg = color.green },
          NvimTreeGitStaged = { fg = color.mauve },
          NvimTreeGitStagedIcon = { fg = color.green },
          NvimTreeGitFileStagedHL = { link = "NvimTreeGitStaged" },
          NvimTreeGitDirtyIcon = { fg = color.red },
          NvimTreeGitFileDirtyHL = { link = "NvimTreeGitDirty" },

          -- Trouble
          TroubleNormal = { bg = transparent_background and color.none or color.base },
          TroubleNormalNC = { bg = transparent_background and color.none or color.base },

          -- For telescope.nvim
          TelescopeMatching = { fg = color.lavender },
          TelescopeResultsDiffAdd = { fg = color.green },
          TelescopeResultsDiffChange = { fg = color.yellow },
          TelescopeResultsDiffDelete = { fg = color.red },
          TelescopeBorder = { fg = color.mantle, bg = color.mantle },
          TelescopeNormal = { bg = color.mantle },
          TelescopePromptBorder = { fg = color.surface0, bg = color.surface0 },
          TelescopePromptNormal = { bg = color.surface0 },
          TelescopePromptPrefix = { bg = color.surface0 },
          TelescopePromptTitle = { fg = color.base, bg = color.red },
          TelescopePreviewTitle = { fg = color.base, bg = color.green },
          TelescopeResultsTitle = { fg = color.mantle, bg = color.lavender },
          TelescopeSelection = { fg = color.text, bg = color.surface0 },

          -- For glance.nvim
          GlanceWinBarFilename = { fg = color.subtext1, style = { "bold" } },
          GlanceWinBarFilepath = { fg = color.subtext0, style = { "italic" } },
          GlanceWinBarTitle = { fg = color.teal, style = { "bold" } },
          GlanceListCount = { fg = color.lavender },
          GlanceListFilepath = { link = "Comment" },
          GlanceListFilename = { fg = color.blue },
          GlanceListMatch = { fg = color.lavender, style = { "bold" } },
          GlanceFoldIcon = { fg = color.green },

          -- noice.nvim
          NoiceCmdlinePopupNormal = { fg = color.text, bg = color.crust },
          NoiceCmdlinePopupBorder = { fg = color.crust, bg = color.crust },
          NoiceConfirm = { link = "NormalFloat" },
          NoiceConfirmBorder = { link = "FloatBorder" },
          NoiceSplit = { link = "Normal" },
          NoiceSplitBorder = { link = "FloatBorder" },
          NoiceMini = { link = "Comment" },

          -- which-key.nvim
          WhichKey = { bg = "NONE", fg = color.text },
        }
      end,
    },
  })
  vim.cmd.colorscheme("catppuccin")
end

return Plugin
