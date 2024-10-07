--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.tool.neo-tree                                        │--
--│  DETAIL: File explorer plugin                                            │--
--│  CREATE: 2024-10-02 by Benjamin Hao                                      │--
--│  UPDATE: 2024-10-02 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: config neotree
local Plugin = {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = "Neotree",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
}

local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, _)
      local actions = require 'telescope.actions'
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require 'telescope.actions.state'
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require('neo-tree.sources.filesystem').navigate(state, state.path, filename, function() end)
      end)
      return true
    end,
  }
end

Plugin.config = function()
  local neotree = require("neo-tree")
  local system = require("my.helpers.system")

  neotree.setup {
    sort_case_insensitive = true,
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    sources = {
      "filesystem",
      "git_status",
    },
    source_selector = {
      winbar = true,
      sources = {
        { source = "filesystem", display_name = " 󰉓 Files " },
        { source = "git_status", display_name = " 󰊢 Git " },
      },
      content_layout = "center",
    },
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        padding = 0,
      },
      icon = {
        folder_empty = "",
        default = "",
        highlight = "None",
      },
      modified = {
        symbol = "[+]",
      },
      git_status = {
        symbols = {
          -- Change type
          added = '󰐖',
          modified = '󰏬',
          deleted = '󰍵',
          renamed = '󰑕', -- this can only be used in the git_status source
          untracked = '󰦓',
          ignored = '󰿠',
          unstaged = '󱗜',
          staged = '󰄲',
          conflict = '󰀧',
        },
      },
      file_size = { enabled = true },
      type = { enabled = false },
      last_modified = { enabled = true },
      created = { enabled = false },
      symlink_target = { enabled = true },
    },
    commands = {
      yank_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local vals = {
          ['BASENAME'] = modify(filename, ':r'),
          ['EXTENSION'] = modify(filename, ':e'),
          ['FILENAME'] = filename,
          ['PATH (CWD)'] = modify(filepath, ':.'),
          ['PATH (HOME)'] = modify(filepath, ':~'),
          ['PATH'] = filepath,
          ['URI'] = vim.uri_from_fname(filepath),
        }

        local options = vim.tbl_filter(function(val)
          return vals[val] ~= ''
        end, vim.tbl_keys(vals))
        if vim.tbl_isempty(options) then
          vim.notify('No values to yank', vim.log.levels.WARN)
          return
        end
        table.sort(options)
        vim.ui.select(options, {
          prompt = 'Choose to yank to clipboard:',
          format_item = function(item)
            return ('%s: %s'):format(item, vals[item])
          end,
        }, function(choice)
            local result = vals[choice]
            if result then
              vim.notify(('Yanked: `%s`'):format(result))
              vim.fn.setreg('+', result)
            end
          end)
      end,
      telescope_find = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require('telescope.builtin').find_files(getTelescopeOpts(state, path))
      end,
      telescope_grep = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require('telescope.builtin').live_grep(getTelescopeOpts(state, path))
      end,
      telescope_find_current_buffer = function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy {
          prompt_title = "Fuzzy Find Neo-Tree",
          previewer = false,
          skip_empty_lines = true,
        })
      end,
      system_open = function(state)
        local command = function()
          if system.is_windows then return "start"
          elseif system.is_mac then return "open"
          elseif system.is_linux then return "xdg-open"
          elseif system.is_wsl then return "wslview"
          end
        end
        local file = state.tree:get_node():get_id()
        vim.notify(string.format("Open with system app: '%s'", file))
        vim.api.nvim_command(string.format("silent !%s '%s'", command(), file))
      end,
    },
    window = {
      position = 'left',
      mappings = {
        ["Space"] = false, -- toggle_node
        ['t'] = false, -- open_tab_new
        ["<Tab>"] = "next_source",
        ["<S-Tab>"] = "prev_source",
        ["l"] = "open",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["h"] = "close_node",
        ["a"] = { "add", config = { show_path = "relative" } },
        ["A"] = "add_directory",
        ["O"] = "system_open",
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        ["b"] = "toggle_node",
        -- ['tf'] = 'telescope_find',
        -- ['tg'] = 'telescope_grep',
        ['Z'] = 'close_all_nodes',
        ['y'] = 'yank_selector',
        ['/'] = 'telescope_find_current_buffer',
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['H'] = "set_root",
          ['u'] = 'navigate_up',
          ["f"] = "filter_on_submit",
          ['.'] = 'toggle_hidden',
        },
      },
      bind_to_cwd = false,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
        },
        hide_by_pattern = {
          "*.meta",
          "*:Zone.Identifier",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
        never_show_by_pattern = {
          ".null-ls_*",
        },
      },
      find_by_full_path_words = true,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    open_files_do_not_replace_types = {
      'terminal',
      'trouble',
      'qf',
      'edgy',
      'telescopeprompt',
      'overseerlist',
      'OverseerList',
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(_)
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
    },

  }
end

return Plugin
