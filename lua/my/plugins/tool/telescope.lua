--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.tool.telescope                                       │--
--│  DETAIL: Fuzzy finder plugin                                             │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim", -- lua functions library
    "nvim-tree/nvim-web-devicons",  -- icons for ui
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- a C port of fzf, Cmake required
    "debugloop/telescope-undo.nvim", -- fuzzy-search undo tree
    "nvim-telescope/telescope-frecency.nvim", -- sorting by frequency and recency
    "nvim-telescope/telescope-live-grep-args.nvim", -- live grep args picker
    -- "ahmedkhalf/project.nvim", -- project management
    "FabianWirth/search.nvim", -- Tabs support
    -- TODO: check { "jvgrootveld/telescope-zoxide" },
  }
}

Plugin.config = function()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local lga_actions = require("telescope-live-grep-args.actions")
  local undo_actions = require("telescope-undo.actions")
  local icons = { ui = require("my.helpers.icons").get("ui", true) }

  telescope.setup({
    ----------------------------- builtin ---------------------------------------
    defaults = {
      prompt_prefix = " " .. icons.ui.Telescope .. " ",
      selection_caret = icons.ui.ChevronRight,
      path_display = { "absolute" },
      sorting_strategy = "ascending",
      results_title = false,
      set_env = { COLORTERM = "truecolor" },
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          width = 0.8,
          preview_cutoff = 120,
        },
        vertical = {
          prompt_position = "bottom",
          height = 0.8,
          preview_cutoff = 40,
          mirror = true,
        },
      },
      file_ignore_patterns = {
        "%.class",
        "%.exe",
        "%.jpeg",
        "%.jpg",
        "%.mkv",
        "%.mp4",
        "%.pdf",
        "%.png",
        "%.zip",
        ".cache",
        ".git/",
        "build/",
        "node_modules",
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-l>"] = actions.select_default,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-cr>"] = require("my.helpers.utils").telescope_reveal_in_nvimtree
        },
        n = {
          ["q"] = actions.close,
          ["?"] = actions.which_key,
          ["<C-cr>"] = require("my.helpers.utils").telescope_reveal_in_nvimtree
        },
      },
    },
    ---------------------------- extensions ----------------------------------
    load_extension = {
      "aerial",
      "frecency",
      "fzf",
      "live_grep_args",
      "notify",
      "projects",
      "undo",
      "yank_history",
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      frecency = {
        show_scores = true,
        show_unindexed = true,
        ignore_patterns = { "*.git/*", "*/tmp/*" },
        prompt_title = 'Frecency',
      },
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
      },
      undo = {
        -- TODO: change keybinds
        side_by_side = true,
        mappings = {
          i = {
            ["<Cr>"] = undo_actions.yank_additions,
            ["<S-Cr>"] = undo_actions.yank_deletions,
            ["<C-Cr>"] = undo_actions.restore,
          },
          n = {
            ["<Cr>"] = undo_actions.yank_additions,
            ["<S-Cr>"] = undo_actions.yank_deletions,
            ["<C-Cr>"] = undo_actions.restore,
          },
        },
      },
    },
  })
end

return Plugin
