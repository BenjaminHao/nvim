--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.tool.nvim-tree                                       │--
--│  DETAIL: File explorer plugin                                            │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: icons, migrate neotree functions
local Plugin = {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeOpen" },
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
}

Plugin.config = function()
  local nvimtree = require("nvim-tree")

  nvimtree.setup({
    on_attach = require("my.keymaps.tool").nvimtree_on_attach,
    hijack_cursor = true,
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    sync_root_with_cwd = true,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    select_prompts = false,
    view = {
      centralize_selection = true,
      side = "left",
      width = 30,
      signcolumn = "yes",
    },
    renderer = {
      full_name = true,
      root_folder_label = ":t",
      highlight_git = "none",
      highlight_diagnostics = "none",
      highlight_opened_files = "none",
      highlight_bookmarks = "none",
      highlight_clipboard = "name",
      indent_markers = {
        enable = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "├",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "after",
        modified_placement = "before",
        diagnostics_placement = "signcolumn",
        bookmarks_placement = "signcolumn",
        padding = " ",
        symlink_arrow = " 󰁔 ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          modified = true,
          diagnostics = true,
          bookmarks = true,
        },
        glyphs = {
          default = "󰈔",
          symlink = "",
          bookmark = "󰓎",
          modified = "󱦹",
          hidden = "󰘓",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "󰀧",
            staged = "󰄲",
            unmerged = "󰦓",
            renamed = "󰑕",
            untracked = "󰞋",
            deleted = "󰅗",
            ignored = "󰿠",
          },
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = false,
      ignore_list = { "help" },
    },
    git = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },
    diagnostics = {
      enable = false,
      show_on_dirs = true,
      show_on_open_dirs = false,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "󰠠",
        info = "",
        warning = "",
        error = "",
      },
    },
    modified = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
    },
    filters = {
      dotfiles = false, -- show dot files
      custom = { "^.git$", ".DS_Store" },
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      open_file = {
        quit_on_open = true,
        eject = true,
        resize_window = true,
        window_picker = {
          enable = true,
          picker = "default",
          chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ",
          exclude = {
            buftype = {
              "help",
              "nofile",
              "prompt",
              "quickfix",
              "terminal",
            },
            filetype = {
              "dap-repl",
              "diff",
              "fugitive",
              "fugitiveblame",
              "git",
              "notify",
              "NvimTree",
              "Outline",
              "qf",
              "TelescopePrompt",
              "toggleterm",
              "undotree",
            },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    trash = {
      cmd = "gio trash",
    },
    notify = {
      threshold = vim.log.levels.INFO,
      absolute_path = true,
    },
    help = {
      sort_by = "desc",
    },
    ui = {
      confirm = {
        remove = true,
        trash = true,
        default_yes = false,
      },
    },
  })
end

return Plugin
