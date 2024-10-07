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
            name = "Find Files (CWD)",
            tele_func = builtin.find_files,
          },
          {
            name = "Find Files (Git)",
            tele_func = builtin.git_files,
            available = function() return vim.fn.isdirectory(".git") == 1 end,
          },
          {
            name = "Find Files (All)",
            tele_func = builtin.find_files,
            tele_opts = { cwd = vim.env.HOME, no_ignore = true, hidden = true }
          },
        },
      },
      recent = {
        initial_tab = 1,
        tabs = {
          {
            name = "Recent Files (History)",
            tele_func = builtin.oldfiles
          },
          {
            name = "Recent Files (Frecency)",
            tele_func = extensions.frecency.frecency
          },
        },
      },
      -- Search word
      word = {
        initial_tab = 1,
        tabs = {
          {
            name = "Fuzzy Find Current",
            tele_func = builtin.current_buffer_fuzzy_find
          },
          {
            name = "Grep Opened Files",
            tele_func = builtin.live_grep,
            tele_opts = { grep_open_files = true },
          },
          {
            name = "Grep Whole Project",
            tele_func = extensions.live_grep_args.live_grep_args
          },
        },
      },
      -- Search Git objects (branches, commits)
      git = {
        initial_tab = 1,
        tabs = {
          {
            name = "Git Branches",
            tele_func = builtin.git_branches,
          },
          {
            name = "Git Commits",
            tele_func = builtin.git_commits,
          },
        },
      },
    },
  })
end

return Plugin
