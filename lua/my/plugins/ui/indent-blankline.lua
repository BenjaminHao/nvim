--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.ui.indent-blankline                                   │--
--│ DESC: Indentation guides for Neovim                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "lukas-reineke/indent-blankline.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
}

Plugin.config = function()
  require("ibl").setup({
    indent = {
      char = "│",
      tab_char = "│",
      smart_indent_cap = true,
      priority = 2,
      repeat_linebreak = true,
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    scope = {
      enabled = true,
      char = nil,
      show_start = false,
      show_end = false,
      injected_languages = true,
      priority = 1000,
      include = {
        node_type = {
          ["*"] = {
            "argument_list",
            "arguments",
            "assignment_statement",
            "Block",
            "class",
            "ContainerDecl",
            "dictionary",
            "do_block",
            "do_statement",
            "element",
            "except",
            "FnCallArguments",
            "for",
            "for_statement",
            "function",
            "function_declaration",
            "function_definition",
            "if_statement",
            "IfExpr",
            "IfStatement",
            "import",
            "InitList",
            "list_literal",
            "method",
            "object",
            "ParamDeclList",
            "repeat_statement",
            "selector",
            "SwitchExpr",
            "table",
            "table_constructor",
            "try",
            "tuple",
            "type",
            "var",
            "while",
            "while_statement",
            "with",
          },
        },
      },
    },
    exclude = {
      filetypes = {
        "",
        "alpha",
        "checkhealth",
        "dashboard",
        "gitcommit",
        "help",
        "lazy",
        "lspinfo",
        "man",
        "mason",
        "notify",
        "NvimTree",
        "spectre_panel",
        "TelescopePrompt",
        "TelescopeResults",
        "toggleterm",
      },
      buftypes = {
        "nofile",
        "prompt",
        "quickfix",
        "terminal",
      },
    },
  })
end

return Plugin
