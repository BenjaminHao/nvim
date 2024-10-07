--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.editor.neotab                                        │--
--│  DETAIL: Tabout, smart semicolon, etc.                                   │--
--│  CREATE: 2024-10-04 by Benjamin Hao                                      │--
--│  UPDATE: 2024-10-04 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "kawre/neotab.nvim",
  event = "InsertEnter",
}

Plugin.config = function()
  require("neotab").setup({
    tabkey = "<Tab>",
    act_as_tab = true,
    behavior = "nested",
    pairs = {
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "<", close = ">" },
    },
    exclude = {},
    smart_punctuators = {
      enabled = true,
      semicolon = {
        enabled = true,
        ft = { "cs", "c", "cpp", "java" },
      },
      escape = {
        enabled = true,
        triggers = {
          ["+"] = {
            pairs = {
              { open = '"', close = '"' },
            },
            -- string.format(format, typed_char)
            format = " %s ",
            ft = { "java" },
          },
          [","] = {
            pairs = {
              { open = "'", close = "'" },
              { open = '"', close = '"' },
            },
            format = "%s ", -- ", "
          },
          ["="] = {
            pairs = {
              { open = "(", close = ")" },
            },
            ft = { "javascript", "typescript" },
            format = " %s> ", -- ` => `
            -- string.match(text_between_pairs, cond)
            cond = "^$", -- match only pairs with empty content
          },
        },
      },
    },
  })
end

return Plugin
