--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ FILE: plugins/nvim-tree.lua                                              │--
--│ DESC: file explorer plugin                                               │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
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
      ["n|?"] = map.func(api.tree.toggle_help):desc("NvimTree: Help"):buf(bufnr),
      ["n|l"] = map.func(api.node.open.edit):desc("NvimTree: Open"):buf(bufnr),
      ["n|<cr>"] = map.func(api.node.open.edit):desc("NvimTree: Open"):buf(bufnr),
      ["n|<Tab>"] = map.func(api.node.open.preview):desc("NvimTree: Open (Preview)"):buf(bufnr),
      ["n|s"] = map.func(api.node.open.horizontal):desc("NvimTree: Open (Horizontal)"):buf(bufnr),
      ["n|v"] = map.func(api.node.open.vertical):desc("NvimTree: Open (Vertical)"):buf(bufnr),
      ["n|o"] = map.func(api.node.run.system):desc("NvimTree: Open (Default App)"):buf(bufnr),
      ["n|i"] = map.func(api.node.show_info_popup):desc("NvimTree: Info"):buf(bufnr),
      ["n|a"] = map.func(api.fs.create):desc("NvimTree: Create"):buf(bufnr),
      ["n|r"] = map.func(api.fs.rename):desc("NvimTree: Rename"):buf(bufnr),
      ["n|c"] = map.func(api.fs.copy.node):desc("NvimTree: Copy"):buf(bufnr),
      ["n|x"] = map.func(api.fs.cut):desc("NvimTree: Cut"):buf(bufnr),
      ["n|p"] = map.func(api.fs.paste):desc("NvimTree: Paste"):buf(bufnr),
      ["n|d"] = map.func(api.fs.remove):desc("NvimTree: Delete"):buf(bufnr),
      ["n|D"] = map.func(api.fs.trash):desc("NvimTree: Trash"):buf(bufnr),
      ["n|y"] = map.func(api.fs.copy.filename):desc("NvimTree: Yank Filename"):buf(bufnr),  -- or .basename
      ["n|Y"] = map.func(api.fs.copy.absolute_path):desc("NvimTree: Yank Absolute Path"):buf(bufnr),
      ["n|."] = map.func(api.tree.toggle_hidden_filter):desc("NvimTree: Toggle Dot Files"):buf(bufnr),
      ["n|J"] = map.func(api.node.navigate.sibling.last):desc("NvimTree: To Last Sibling"):buf(bufnr),
      ["n|K"] = map.func(api.node.navigate.sibling.first):desc("NvimTree: To First Sibling"):buf(bufnr),
      ["n|h"] = map.func(api.node.navigate.parent):desc("NvimTree: To Parent Directory"):buf(bufnr),
      ["n|H"] = map.func(api.tree.change_root_to_node):desc("NvimTree: Set Root Directory"):buf(bufnr),
      ["n|u"] = map.func(api.tree.change_root_to_parent):desc("NvimTree: Show parent root"):buf(bufnr),
      ["n|q"] = map.func(api.tree.close):desc("NvimTree: Close"):buf(bufnr),
      ["n|<esc>"] = map.func(api.tree.close):desc("NvimTree: Close"):buf(bufnr),
      ["n|R"] = map.func(api.tree.reload):desc("NvimTree: Refresh"):buf(bufnr),
      -- ["n|S"] = map.func(api.tree.search_node):desc("NvimTree: Search"):buf(bufnr), -- this sucks
      -- ["n|t"] = map.func(api.tree.toggle_custom_filter):desc("NvimTree: Toggle Custom Filter"):buf(buf),
      -- ["n|m"] = map.func(api.marks.toggle):desc("NvimTree: Set Bookmark"):buf(bufnr),
      -- ["n|M"] = map.func(api.tree.toggle_no_bookmark_filter):desc("NvimTree: Toggle Bookmarks"):buf(bufnr),
      -- ["n|e"] = map.func(api.node.run.cmd):desc("NvimTree: Execute Command"):buf(bufnr),
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
