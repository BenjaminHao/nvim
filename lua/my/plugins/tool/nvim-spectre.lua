--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.tool.nvim-spectre                                    │--
--│  DETAIL: Search and Replace in projects                                  │--
--│  CREATE: 2024-09-19 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "nvim-pack/nvim-spectre",
  cmd = "Spectre",
}

Plugin.config = function()
  require("spectre").setup({
    open_cmd = "noswapfile vnew",
    mapping = {
      ["toggle_line"] = {
        map = "dd",
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = "toggle current item",
      },
      ["enter_file"] = {
        map = "<cr>",
        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
        desc = "goto current file",
      },
      ["send_to_qf"] = {
        map = "\\q",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix",
      },
      ["replace_cmd"] = {
        map = "\\c",
        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = "input replace vim command",
      },
      ["show_option_menu"] = {
        map = "\\o",
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = "show option",
      },
      ["run_replace"] = {
        map = "\\R",
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = "replace all",
      },
      ["change_view_mode"] = {
        map = "\\v",
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = "change result view mode",
      },
      ["toggle_live_update"] = {
        map = "tu",
        cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
        desc = "update change when vim write file.",
      },
      ["toggle_ignore_case"] = {
        map = "ti",
        cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
        desc = "toggle ignore case",
      },
      ["toggle_ignore_hidden"] = {
        map = "th",
        cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
        desc = "toggle search hidden",
      },
      ["resume_last_search"] = {
        map = "\\l",
        cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
        desc = "resume last search before close",
      },
    },
  })
end

return Plugin
