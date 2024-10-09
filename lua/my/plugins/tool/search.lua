--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.tool.search                                          │--
--│  DETAIL: Switching search modes within Telescope window                  │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "FabianWirth/search.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}

Plugin.config = function()
  local builtin = require("telescope.builtin")
  local extensions = require("telescope").extensions

  require("search").setup({
    collections = {
      -- Search files
      file = {
        initial_tab = 1,
        tabs = {
          {
            name = "CWD",
            tele_func = function()
              builtin.find_files({
                prompt_title = "CWD Files",
              })
            end,
          },
          {
            name = "Git",
            tele_func = function()
              builtin.git_files({
                prompt_title = "Git Files",
              })
            end,
            available = function()
              return vim.fn.isdirectory(".git") == 1
            end,
          },
          {
            name = "All",
            tele_func = function()
              builtin.find_files({
                prompt_title = "All Files",
                cwd = vim.env.HOME,
                no_ignore = true,
                hidden = true,
              })
            end,
          },
        },
      },
      recent = {
        initial_tab = 1,
        tabs = {
          {
            name = "History",
            tele_func = function()
              builtin.oldfiles({
                prompt_title = "Recent Files (History)",
              })
            end,
          },
          {
            name = "Frecency",
            tele_func = function()
              extensions.frecency.frecency({
                prompt_title = "Recent Files (Frecency)",
              })
            end,
          },
        },
      },
      -- Search word
      word = {
        initial_tab = 1,
        tabs = {
          {
            name = "Current Buffer",
            tele_func = function()
              builtin.current_buffer_fuzzy_find({
                prompt_title = "Fuzzy Find (Current Buffer)",
              })
            end,
          },
          {
            name = "Opened Files",
            tele_func = function()
              builtin.live_grep({
                prompt_title = "Live Grep (Opened Files)",
                grep_open_files = true
              })
            end,
          },
          {
            name = "Whole Project",
            tele_func = function()
              extensions.live_grep_args.live_grep_args({
                prompt_title = "Live Grep (Current Working Directory)",
              })
            end,
          },
        },
      },
      -- Search Git objects (branches, commits)
      git = {
        initial_tab = 1,
        tabs = {
          {
            name = "Branches",
            tele_func = function()
              builtin.git_branches({
                prompt_title = "Git Branches",
              })
            end,
          },
          {
            name = "Commits",
            tele_func = function()
              builtin.git_commits({
                prompt_title = "Git Commits",
              })
            end,
          },
        },
      },
    },
  })
end

return Plugin
