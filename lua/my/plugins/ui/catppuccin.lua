--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.ui.catppuccin                                        │--
--│  DETAIL: Beautiful colorscheme                                           │--
--│  CREATE: nvimdots                                                        │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "catppuccin/nvim",
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
      alpha = true,
      barbar = false,
      beacon = false,
      cmp = true,
      coc_nvim = false,
      dap = true,
      dap_ui = true,
      dashboard = false,
      dropbar = { enabled = false, color_mode = true },
      fern = false,
      fidget = false,
      flash = true,
      gitgutter = false,
      gitsigns = true,
      harpoon = false,
      headlines = false,
      hop = false,
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
      neotree = { enabled = true, show_root = true, transparent_panel = false },
      noice = true,
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
      ts_rainbow = true,
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
          -- Base configs
          NormalFloat = {
            bg = transparent_background and color.none or color.mantle,
          },
          FloatBorder = {
            fg = transparent_background and color.blue or color.mantle,
            bg = transparent_background and color.none or color.mantle,
          },
          FloatTitle = { bg = color.sky, fg = color.base },
          CursorLineNr = { fg = color.green },
          WinSeparator = { bg = color.none, fg = color.mantle },
          VertSplit = { bg = color.none, fg = color.mantle },
          ModeMsg = { fg = color.peach }, -- for recording macro msg
          LspReferenceText = { underline = true },
          LspReferenceRead = { underline = true },
          LspReferenceWrite = { underline = true },

          -- Lazy
          LazyH1 = { bg = color.green, fg = color.base },
          LazyButton = { bg = color.base, fg = color.subtext1 },
          LazyH2 = { fg = color.red, bold = true, underline = true },
          LazyReasonPlugin = { fg = color.red },
          LazyValue = { fg = color.teal },
          LazyDir = { fg = color.sky },
          LazyUrl = { fg = color.sky },
          LazyCommit = { fg = color.green },
          LazyNoCond = { fg = color.red },
          LazySpecial = { fg = color.blue },
          LazyReasonFt = { fg = color.purple },
          LazyOperator = { fg = color.white },
          LazyReasonKeys = { fg = color.teal },
          LazyTaskOutput = { fg = color.white },
          LazyCommitIssue = { fg = color.pink },
          LazyReasonEvent = { fg = color.yellow },
          LazyReasonStart = { fg = color.white },
          LazyReasonRuntime = { fg = color.blue },
          LazyReasonCmd = { fg = color.sun },
          LazyReasonSource = { fg = color.cyan },
          LazyReasonImport = { fg = color.white },
          LazyProgressDone = { fg = color.green },

          -- Treesitter
          ["@variable"] = { link = "Variable" },
          ["@keyword.return"] = { fg = color.pink, style = clear },
          ["@error.c"] = { fg = color.none, style = clear },
          ["@error.cpp"] = { fg = color.none, style = clear },
          ["@punctuation.special.markdown"] = { fg = color.teal },
          ["@text.title.1.markdown"] = { fg = color.red },
          ["@text.title.1.marker.markdown"] = { fg = color.red },
          ["@text.title.2.markdown"] = { fg = color.peach },
          ["@text.title.2.marker.markdown"] = { fg = color.peach },
          ["@text.title.3.markdown"] = { fg = color.yellow },
          ["@text.title.3.marker.markdown"] = { fg = color.yellow },
          ["@text.title.4.markdown"] = { fg = color.green },
          ["@text.title.4.marker.markdown"] = { fg = color.green },
          ["@text.title.5.markdown"] = { fg = color.blue },
          ["@text.title.5.marker.markdown"] = { fg = color.blue },
          ["@text.literal.markdown_inline"] = { fg = color.green },
          ["@text.reference.markdown_inline"] = { fg = color.lavender },
          ["@text.strong.markdown_inline"] = { fg = color.red },
          ["@text.uri.markdown_inline"] = { fg = color.blue },

          -- Nvim-web-devicons
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

          -- Diagnostics
          DiagnosticVirtualTextError = { bg = color.none },
          DiagnosticVirtualTextWarn = { bg = color.none },
          DiagnosticVirtualTextInfo = { bg = color.none },
          DiagnosticVirtualTextHint = { bg = color.none },
          LspInfoBorder = { link = "FloatBorder" },
          DiagnosticUnderlineError = { undercurl = true, sp = color.red }, -- Used to underline "Error" diagnostics
          DiagnosticUnderlineWarn = { undercurl = true, sp = color.peach }, -- Used to underline "Warning" diagnostics
          DiagnosticUnderlineInfo = { undercurl = true, sp = color.sky }, -- Used to underline "Information" diagnostics
          DiagnosticUnderlineHint = { undercurl = true, sp = color.mauve }, -- Used to underline "Hint" diagnostics
          ErrorMsg = { fg = color.red }, -- error messages on the command line
          SpellBad = { sp = color.red, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
          SpellCap = { sp = color.peach, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
          SpellLocal = { sp = color.sky, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
          SpellRare = { sp = color.mauve, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
          DiagnosticError = { fg = color.red }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
          DiagnosticWarn = { fg = color.peach }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
          DiagnosticInfo = { fg = color.sky }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
          DiagnosticHint = { fg = color.mauve }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
          -- DiagnosticUnnecessary = { fg = color.sun, link = nil },
          DiagnosticFloatingError = { fg = color.red }, -- Used to color "Error" diagnostic messages in diagnostics float
          DiagnosticFloatingWarn = { fg = color.peach }, -- Used to color "Warn" diagnostic messages in diagnostics float
          DiagnosticFloatingInfo = { fg = color.sky }, -- Used to color "Info" diagnostic messages in diagnostics float
          DiagnosticFloatingHint = { fg = color.mauve }, -- Used to color "Hint" diagnostic messages in diagnostics float

          -- Mason
          MasonNormal = { link = "NormalFloat" },

          -- Bufferline
          BufferLineOffset = { bg = color.mantle, fg = color.lavender },
          DevIconDimmed = { fg = color.surface1 },

          -- Indent-blankline
          IblIndent = { fg = color.surface0 },
          IblScope = { fg = color.surface2, style = { "bold" } },

          -- Flash
          FlashMatch = { bg = color.none, fg = color.blue },
          FlashCurrent = { bg = color.none, fg = color.blue },
          FlashLabel = { bg = color.none, fg = color.red, underline = true, bold = true },
          FlashCursor = { reverse = true },
          FlashPrompt = { link = "Normal" },
          FlashPromptMode = { bg = color.none, fg = color.yellow },

          -- LspKindIcons
          LspKindClass = { fg = color.yellow },
          LspKindConstant = { fg = color.peach },
          LspKindConstructor = { fg = color.sapphire },
          LspKindEnum = { fg = color.yellow },
          LspKindEnumMember = { fg = color.teal },
          LspKindEvent = { fg = color.yellow },
          LspKindField = { fg = color.teal },
          LspKindFile = { fg = color.rosewater },
          LspKindFunction = { fg = color.blue },
          LspKindInterface = { fg = color.yellow },
          LspKindKey = { fg = color.red },
          LspKindMethod = { fg = color.blue },
          LspKindModule = { fg = color.blue },
          LspKindNamespace = { fg = color.blue },
          LspKindNumber = { fg = color.peach },
          LspKindOperator = { fg = color.sky },
          LspKindPackage = { fg = color.blue },
          LspKindProperty = { fg = color.teal },
          LspKindStruct = { fg = color.yellow },
          LspKindTypeParameter = { fg = color.blue },
          LspKindVariable = { fg = color.peach },
          LspKindArray = { fg = color.peach },
          LspKindBoolean = { fg = color.peach },
          LspKindNull = { fg = color.yellow },
          LspKindObject = { fg = color.yellow },
          LspKindString = { fg = color.green },
          LspKindTypeAlias = { fg = color.green },
          LspKindParameter = { fg = color.blue },
          LspKindStaticMethod = { fg = color.peach },
          LspKindText = { fg = color.green },
          LspKindSnippet = { fg = color.mauve },
          LspKindFolder = { fg = color.blue },
          LspKindUnit = { fg = color.green },
          LspKindValue = { fg = color.peach },

          -- Nvim-cmp
          CmpItemKindSnippet = { bg = color.mauve, fg = color.base, bold = true },
          CmpItemKindKeyword = { bg = color.red, fg = color.base, bold = true },
          CmpItemKindText = { bg = color.teal, fg = color.base, bold = true },
          CmpItemKindMethod = { bg = color.blue, fg = color.base, bold = true },
          CmpItemKindConstructor = { bg = color.blue, fg = color.base, bold = true },
          CmpItemKindFunction = { bg = color.blue, fg = color.base, bold = true },
          CmpItemKindFolder = { bg = color.blue, fg = color.base, bold = true },
          CmpItemKindModule = { bg = color.blue, fg = color.base, bold = true },
          CmpItemKindConstant = { bg = color.peach, fg = color.base, bold = true },
          CmpItemKindField = { bg = color.green, fg = color.base, bold = true },
          CmpItemKindProperty = { bg = color.green, fg = color.base, bold = true },
          CmpItemKindEnum = { bg = color.green, fg = color.base, bold = true },
          CmpItemKindUnit = { bg = color.green, fg = color.base, bold = true },
          CmpItemKindClass = { bg = color.yellow, fg = color.base, bold = true },
          CmpItemKindVariable = { bg = color.flamingo, fg = color.base, bold = true },
          CmpItemKindFile = { bg = color.blue, fg = color.base, bold = true },
          CmpItemKindInterface = { bg = color.yellow, fg = color.base, bold = true },
          CmpItemKindColor = { bg = color.red, fg = color.base, bold = true },
          CmpItemKindReference = { bg = color.red, fg = color.base, bold = true },
          CmpItemKindEnumMember = { bg = color.red, fg = color.base, bold = true },
          CmpItemKindStruct = { bg = color.blue, fg = color.base, bold = true },
          CmpItemKindValue = { bg = color.peach, fg = color.base, bold = true },
          CmpItemKindEvent = { bg = color.blue, fg = color.base, bold = true },
          CmpItemKindOperator = { bg = color.blue, fg = color.base, bold = true },
          CmpItemKindTypeParameter = { bg = color.blue, fg = color.base, bold = true },
          CmpItemKindCopilot = { bg = color.teal, fg = color.base, bold = true },
          Pmenu = { fg = color.overlay2, bg = transparent_background and color.none or color.base },
          PmenuBorder = { fg = color.surface1, bg = transparent_background and color.none or color.base },
          PmenuSel = { bg = color.green, fg = color.base },
          CmpItemAbbr = { fg = color.text },
          CmpItemAbbrMatch = { fg = color.blue, bold = true },
          CmpSel = { link = "PmenuSel", bold = true },
          CmpDoc = { link = "NormalFloat" },
          CmpDocBorder = {
            fg = transparent_background and color.surface1 or color.mantle,
            bg = transparent_background and color.none or color.mantle,
          },

          -- Neo-tree
          -- NeoTreeFloatTitle = { bg = color.sky, fg = color.base },
          NeoTreeGitAdded = { fg = color.green },
          NeoTreeGitConflict = { fg = color.peach },
          NeoTreeGitDeleted = { fg = color.red },
          NeoTreeGitIgnored = { fg= color.surface1_fg },
          NeoTreeGitModified = { fg = color.flamingo },
          NeoTreeGitUntracked = { fg = color.sky },
          NeoTreeGitUnstaged = { fg = color.sapphire },
          NeoTreeGitStaged = { fg = color.blue },

          -- Fidget
          FidgetTask = { bg = color.none, fg = color.surface2 },
          FidgetTitle = { fg = color.blue, style = { "bold" } },

          -- For nvim-notify
          NotifyBackground = { bg = color.base },

          -- Trouble
          TroubleNormal = { bg = transparent_background and color.none or color.base },
          TroubleNormalNC = { bg = transparent_background and color.none or color.base },

          -- Telescope
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

          -- Glance
          GlanceWinBarFilename = { fg = color.subtext1, style = { "bold" } },
          GlanceWinBarFilepath = { fg = color.subtext0, style = { "italic" } },
          GlanceWinBarTitle = { fg = color.teal, style = { "bold" } },
          GlanceListCount = { fg = color.lavender },
          GlanceListFilepath = { link = "Comment" },
          GlanceListFilename = { fg = color.blue },
          GlanceListMatch = { fg = color.lavender, style = { "bold" } },
          GlanceFoldIcon = { fg = color.green },

          -- Noice
          NoiceCmdlinePopupNormal = { fg = color.text, bg = color.crust },
          NoiceCmdlinePopupBorder = { fg = color.crust, bg = color.crust },
          NoiceConfirm = { link = "NormalFloat" },
          NoiceConfirmBorder = { link = "FloatBorder" },
          NoiceSplit = { link = "Normal" },
          NoiceSplitBorder = { link = "FloatBorder" },
          NoiceMini = { link = "Comment" },

          -- Which-key
          WhichKey = { bg = "NONE", fg = color.text },

          -- Alpha
          AlphaHeader = { fg = color.lavender },
          AlphaButtons = { fg = color.blue },
          AlphaShortcut = { fg = color.pink, style = { "bold" } },
          AlphaFooter = { fg = color.yellow },
        }
      end,
    },
  })
  vim.cmd.colorscheme("catppuccin")
end

return Plugin
