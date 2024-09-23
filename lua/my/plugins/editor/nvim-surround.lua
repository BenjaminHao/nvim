--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.editor.nvim-surround                                 │--
--│  DETAIL: Surround seletions                                              │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "kylechui/nvim-surround",
  event = { "BufReadPost", "BufNewFile" },
  version = "*",
}

Plugin.config = function()
  require("nvim-surround").setup({
    keymaps = {
      insert = false,
      insert_line = false,
      normal = "s",
      normal_cur = "ss",
      normal_line = "S",
      normal_cur_line = "SS",
      visual = "s",
      visual_line = "S",
      delete = "ds",
      change = "cs",
      change_line = "cS"
    },
  })
end

return Plugin
