--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.editor.nvim-surround                                  │--
--│ DESC: surround selections                                                │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "kylechui/nvim-surround",
  event = { "BufReadPost", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
}

-- TODO: maybe need to change key binds later
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
