--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.tool.search                                           │--
--│ DESC: Switch search modes within the Telescope window usings tabs        │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "FabianWirth/search.nvim",
}

Plugin.config = function()
  local builtin = require("telescope.builtin")
  local extensions = require("telescope").extensions

  require("search").setup({
    collections = {
      -- Search using filenames
      file = {
        initial_tab = 1,
        tabs = {
          -- TODO: add file search tabs
          {
            name = "Files",
            tele_func = function(opts)
              opts = opts or {}
              if vim.fn.isdirectory(".git") == 1 then
                builtin.git_files(opts)
              else
                builtin.find_files(opts)
              end
            end,
          },
        },
      },
      recent = {
        initial_tab = 1,
        tabs = {
          {
            name = "Oldfiles",
            tele_func = function()
              builtin.oldfiles()
            end,
          },
          {
            name = "Frecency",
            tele_func = function()
              extensions.frecency.frecency()
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
              builtin.current_buffer_fuzzy_find()
            end,
          },
          {
            name = "Opened Files",
            tele_func = function()
              builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
              }
            end,
          },
          {
            name = "Whole Project",
            tele_func = function()
              extensions.live_grep_args.live_grep_args()
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
              builtin.git_branches()
            end,
          },
          {
            name = "Commits",
            tele_func = function()
              builtin.git_commits()
            end,
          },
          {
            name = "Commit content",
            tele_func = function()
              extensions.advanced_git_search.search_log_content()
            end,
          },
          {
            name = "Diff current file with commit",
            tele_func = function()
              extensions.advanced_git_search.diff_commit_file()
            end,
          },
        },
      },
    },
  })
end

return Plugin
