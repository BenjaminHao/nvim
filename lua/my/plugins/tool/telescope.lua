--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.tool.telescope                                        │--
--│ DESC: Fuzzy finder plugin                                                │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    { "nvim-lua/plenary.nvim" }, -- lua functions library
    { "nvim-tree/nvim-web-devicons" },  -- icons for ui
    { "ahmedkhalf/project.nvim" }, -- project management
    { "FabianWirth/search.nvim" }, -- Tabs support
    { "debugloop/telescope-undo.nvim" }, -- fuzzy-search undo tree
    { "nvim-telescope/telescope-frecency.nvim" }, -- sorting by frequency and recency
    { "nvim-telescope/telescope-live-grep-args.nvim" }, -- live grep args picker
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- a C port of fzf, Cmake required
    -- TODO: check { "jvgrootveld/telescope-zoxide" },
  }
}

Plugin.init = function()
  local map = require("my.helpers.map")
  local keymaps = {
    -- ["n|<Leader>ff"] = bind.cmd("Telescope find_files"):desc("Find: Files"),
    ["n|<Leader>fh"] = map.cmd("Telescope help_tags"):desc("Find: Help"),
    ["n|<Leader>fp"] = map.cmd("Telescope projects"):desc("Find: Projects"),
    ["n|<Leader>fk"] = map.cmd("Telescope keymaps"):desc("Find: Keymaps"),
    ["n|<Leader>fu"] = map.cmd("Telescope undo"):desc("Find: Undo history"),
    ["n|<Leader>fb"] = map.cmd("Telescope buffers"):desc("Find: Buffers"),
    ["n|<Leader>fd"] = map.cmd("Telescope diagnostics"):desc("Find: Diagnostics"),
    ["n|<Leader>fw"] = map.cmd("Telescope live_grep"):desc("Find: Word"),
    ["n|<Leader>fr"] = map.cmd("Telescope oldfiles"):desc("Find: Recent File by history"),
    ["n|<Leader>fR"] = map.cmd("Telescope frecency"):desc("Find: Recent File by frecency"),
    ["n|<Leader>f<Cr>"] = map.cmd("Telescope resume"):desc("Find: Resume last find"),
    --["n|<leader>/"] = map_fun(f.telescope_search):desc("Find: Word in current buffer"),
    --["v|<leader>f"] = map_fun(f.telescope_vmode):desc("Find: Selection"),
    -- todo-comments
    ["n|<Leader>ft"] = map.cmd("TodoTelescope"):desc("Find: Todo"),
  }

  map.setup(keymaps)
end

Plugin.config = function()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local lga_actions = require("telescope-live-grep-args.actions")
  local undo_actions = require("telescope-undo.actions")
  local icons = { ui = require("my.helpers.icons").get("ui", true) }
  local file_filter = require("my.helpers.filter").get("telescope_ignore_file")

  telescope.setup({
    ----------------------------- builtin ---------------------------------------
    defaults = {
      prompt_prefix = " " .. icons.ui.Telescope .. " ",
      selection_caret = icons.ui.ChevronRight,
      path_display = { "absolute" },
      sorting_strategy = "ascending",
      results_title = false,
      set_env = { COLORTERM = "truecolor" },
      file_ignore_patterns = file_filter,
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
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-l>"] = actions.select_default,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<C-u>"] = actions.preview_scrolling_up,
        },
        n = {
          ["q"] = actions.close,
          ["?"] = actions.which_key,
        },
      },
    },
    ---------------------------- extensions ----------------------------------
    load_extension = {
      "frecency",
      "fzf",
      "lazygit",
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
