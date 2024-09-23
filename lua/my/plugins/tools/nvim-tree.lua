--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.tools.nvim-tree                                      │--
--│  DETAIL: File explorer plugin                                            │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: icons
local Plugin = {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeOpen" },
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
}

Plugin.config = function()
  local nvimtree = require("nvim-tree")
  -------------------------- nvimtree key binds ------------------------------
  local function on_attach(bufnr)
    local map = require("my.helpers.map")
    local api = require "nvim-tree.api"
    local keymaps = {
      ["n|?"] = map.func(api.tree.toggle_help):buf(bufnr):desc("NvimTree: Help"),
      ["n|l"] = map.func(api.node.open.edit):buf(bufnr):desc("NvimTree: Open"),
      ["n|<cr>"] = map.func(api.node.open.edit):buf(bufnr):desc("NvimTree: Open"),
      ["n|<Tab>"] = map.func(api.node.open.preview):buf(bufnr):desc("NvimTree: Open (Preview)"),
      ["n|s"] = map.func(api.node.open.horizontal):buf(bufnr):desc("NvimTree: Open (Horizontal)"),
      ["n|v"] = map.func(api.node.open.vertical):buf(bufnr):desc("NvimTree: Open (Vertical)"),
      ["n|o"] = map.func(api.node.run.system):buf(bufnr):desc("NvimTree: Open (Default App)"),
      ["n|i"] = map.func(api.node.show_info_popup):buf(bufnr):desc("NvimTree: Info"),
      ["n|a"] = map.func(api.fs.create):buf(bufnr):desc("NvimTree: Create"),
      ["n|r"] = map.func(api.fs.rename):buf(bufnr):desc("NvimTree: Rename"),
      ["n|c"] = map.func(api.fs.copy.node):buf(bufnr):desc("NvimTree: Copy"),
      ["n|x"] = map.func(api.fs.cut):buf(bufnr):desc("NvimTree: Cut"),
      ["n|p"] = map.func(api.fs.paste):buf(bufnr):desc("NvimTree: Paste"),
      ["n|d"] = map.func(api.fs.remove):buf(bufnr):desc("NvimTree: Delete"),
      ["n|D"] = map.func(api.fs.trash):buf(bufnr):desc("NvimTree: Trash"),
      ["n|y"] = map.func(api.fs.copy.filename):buf(bufnr):desc("NvimTree: Yank Filename"),  -- or .basename
      ["n|Y"] = map.func(api.fs.copy.absolute_path):buf(bufnr):desc("NvimTree: Yank Absolute Path"),
      ["n|."] = map.func(api.tree.toggle_hidden_filter):buf(bufnr):desc("NvimTree: Toggle Dot Files"),
      ["n|J"] = map.func(api.node.navigate.sibling.last):buf(bufnr):desc("NvimTree: To Last Sibling"),
      ["n|K"] = map.func(api.node.navigate.sibling.first):buf(bufnr):desc("NvimTree: To First Sibling"),
      ["n|h"] = map.func(api.node.navigate.parent):buf(bufnr):desc("NvimTree: To Parent Directory"),
      ["n|H"] = map.func(api.tree.change_root_to_node):buf(bufnr):desc("NvimTree: Set Root Directory"),
      ["n|u"] = map.func(api.tree.change_root_to_parent):buf(bufnr):desc("NvimTree: Show parent root"),
      ["n|q"] = map.func(api.tree.close):buf(bufnr):desc("NvimTree: Close"),
      ["n|<esc>"] = map.func(api.tree.close):buf(bufnr):desc("NvimTree: Close"),
      ["n|R"] = map.func(api.tree.reload):buf(bufnr):desc("NvimTree: Refresh"),
      -- ["n|S"] = map.func(api.tree.search_node):buf(bufnr):desc("NvimTree: Search"), -- this sucks
      -- ["n|t"] = map.func(api.tree.toggle_custom_filter):buf(bufnr):desc("NvimTree: Toggle Custom Filter"),
      -- ["n|m"] = map.func(api.marks.toggle):buf(bufnr):desc("NvimTree: Set Bookmark"),
      -- ["n|M"] = map.func(api.tree.toggle_no_bookmark_filter):buf(bufnr):desc("NvimTree: Toggle Bookmarks"),
      -- ["n|e"] = map.func(api.node.run.cmd):buf(bufnr):desc("NvimTree: Execute Command"),
    }
    map.setup(keymaps)
  end

  ---------------------------- nvimtree setup --------------------------------
  nvimtree.setup({
    on_attach = on_attach,
    disable_netrw = true,
    hijack_netrw = true,
    auto_reload_on_write = true,
    open_on_tab = false,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    -- respect_buf_cwd = true,  -- will change cwd every time entering a buffer
    -- reload_on_bufenter = true,
    actions = {
      use_system_clipboard = true,
      open_file = {
        quit_on_open = true,
        eject = true,
        resize_window = true,
        window_picker = {
          enable = true,
          chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", "dbui", "dbout" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
      change_dir = {
        enable = true,
        global = true,  -- also change other plugins cwd (eg. Telescope)
        restrict_above_cwd = false,
      },
      remove_file = {
        close_window = true,
      }
    },
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = { "help" },
    },
    system_open = {
      cmd = "",
      args = {},
    },
    filters = {
      dotfiles = false, -- show dot files by default
      custom = { "^.git$" }, -- not showing .git folder
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 400,
    },
    view = {
      width = 30,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
    renderer = {
      root_folder_label = ":t",
      add_trailing = false,
      group_empty = true,
      full_name = true,
      highlight_git = "none",
      highlight_diagnostics = "none",
      highlight_opened_files = "none",
      highlight_bookmarks = "none",
      highlight_clipboard = "name",
      indent_markers = {
        enable = true,
        icons = {
          corner = "┗",
          edge = "┃",
          item = "┣",
          bottom = "━",
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "before",
        modified_placement = "after",
        diagnostics_placement = "signcolumn",
        bookmarks_placement = "signcolumn",
        padding = " ",
        symlink_arrow = " ➛ ",
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
          default = "",
          symlink = "",
          bookmark = "󱝵",
          modified = "󱇨",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "",
            unmerged = "󰽜",
            renamed = "",
            untracked = "",
            deleted = "",
            ignored = "",
          },
        },
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    trash = {
      cmd = "trash",
      require_confirm = true,
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
        default_yes = true,
      },
    },
  })
end

return Plugin
