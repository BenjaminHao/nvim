--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.ui.lualine                                           │--
--│  DETAIL: Statusline plugin                                               │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

Plugin.config = function()
  local has_catppuccin = vim.g.colors_name:find("catppuccin") ~= nil
  local colors = require("my.helpers.colors").get_palette()
  local icons = {
    diagnostics = require("my.helpers.icons").get("diagnostics", true),
    git = require("my.helpers.icons").get("git", true),
    git_nosep = require("my.helpers.icons").get("git"),
    misc = require("my.helpers.icons").get("misc", true),
    ui = require("my.helpers.icons").get("ui", true),
  }

  local function custom_theme()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("LualineColorScheme", { clear = true }),
      pattern = "*",
      callback = function()
        has_catppuccin = vim.g.colors_name:find("catppuccin") ~= nil
        require("lualine").setup({ options = { theme = custom_theme() } })
      end,
    })

    if has_catppuccin then
      local universal_bg = require("my.configs.settings").transparent_background and "NONE" or colors.mantle
      return {
        normal = {
          a = { fg = colors.lavender, bg = colors.surface0, gui = "bold" },
          b = { fg = colors.text, bg = universal_bg },
          c = { fg = colors.text, bg = universal_bg },
        },
        command = {
          a = { fg = colors.peach, bg = colors.surface0, gui = "bold" },
        },
        insert = {
          a = { fg = colors.green, bg = colors.surface0, gui = "bold" },
        },
        visual = {
          a = { fg = colors.flamingo, bg = colors.surface0, gui = "bold" },
        },
        terminal = {
          a = { fg = colors.teal, bg = colors.surface0, gui = "bold" },
        },
        replace = {
          a = { fg = colors.red, bg = colors.surface0, gui = "bold" },
        },
        inactive = {
          a = { fg = colors.subtext0, bg = universal_bg, gui = "bold" },
          b = { fg = colors.subtext0, bg = universal_bg },
          c = { fg = colors.subtext0, bg = universal_bg },
        },
      }
    else
      return "auto"
    end
  end

  local conditionals = {
    has_enough_room = function()
      return vim.o.columns > 100
    end,
    has_filetype = function()
      return vim.bo.filetype ~= ""
    end,
    has_git = function()
      local gitdir = vim.fs.find(".git", {
        limit = 1,
        upward = true,
        type = "directory",
        path = vim.fn.expand("%:p:h"),
      })
      return #gitdir > 0
    end,
  }

  ---@class lualine_hlgrp
  ---@field fg string
  ---@field bg string
  ---@field gui string?
  local utils = {
    force_centering = function()
      return "%="
    end,

    abbreviate_path = function(path)
      local home = require("my.helpers.system").home_dir
      if path:find(home, 1, true) == 1 then
        path = "~" .. path:sub(#home + 1)
      end
      return path
    end,
    ---Generate <func>`color` for any component
    ---@param fg string @Foreground hl group
    ---@param gen_bg boolean @Generate guibg from hl group |StatusLine|?
    ---@param special_nobg boolean @Disable guibg for transparent backgrounds?
    ---@param bg string? @Background hl group
    ---@param gui string? @GUI highlight arguments
    ---@return nil|fun():lualine_hlgrp
    gen_hl = function(fg, gen_bg, special_nobg, bg, gui)
      if has_catppuccin then
        return function()
          local guifg = colors[fg]
          local guibg = gen_bg and require("my.helpers.colors").hl_to_rgb("StatusLine", true, colors.mantle)
          or colors[bg]
          local nobg = special_nobg
          return {
            fg = guifg and guifg or colors.none,
            bg = (guibg and not nobg) and guibg or colors.none,
            gui = gui and gui or nil,
          }
        end
      else
        -- Return `nil` if the theme is user-defined
        return nil
      end
    end,
  }

  local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end

  local components = {
    separator = { -- use as section separators
      function()
        return "│"
      end,
      padding = 0,
      color = utils.gen_hl("surface1", true, true),
      separator = { left = "", right = "" },
    },

    file_status = {
      function()
        local function is_new_file()
          local filename = vim.fn.expand("%")
          return filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0
        end

        local symbols = {}
        if vim.bo.modified then
          table.insert(symbols, "[+]")
        end
        if vim.bo.modifiable == false then
          table.insert(symbols, "[-]")
        end
        if vim.bo.readonly == true then
          table.insert(symbols, "[RO]")
        end
        if is_new_file() then
          table.insert(symbols, "[New]")
        end
        return #symbols > 0 and table.concat(symbols, "") or ""
      end,
      padding = { left = -1, right = 1 },
      cond = conditionals.has_filetype,
    },

    macro = {
      function()
        -- Autocmd to track macro recording, and redraw statusline
        -- vim.api.nvim_create_autocmd("RecordingEnter", {
        --   pattern = "*",
        --   callback = function()
        --     vim.cmd("redrawstatus")
        --   end,
        -- })
        -- -- Autocmd to track the end of macro recording
        -- vim.api.nvim_create_autocmd("RecordingLeave", {
        --   pattern = "*",
        --   callback = function()
        --     vim.cmd("redrawstatus")
        --   end,
        -- })

        if vim.fn.reg_recording() ~= "" then
          return "Recording @" .. vim.fn.reg_recording()
        else
          return ""
        end
      end,
      padding = 1,
      color = utils.gen_hl("red", true, true, nil, "bold"),
    },

    lsp = {
      function()
        local buf_ft = vim.bo.filetype
        local clients = vim.lsp.get_clients({ buffer = vim.api.nvim_get_current_buf() })
        local lsp_lists = {}
        local available_servers = {}
        if next(clients) == nil then
          return icons.misc.NoActiveLsp -- No server available
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          local client_name = client.name
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            -- Avoid adding servers that already exists.
            if not lsp_lists[client_name] then
              lsp_lists[client_name] = true
              table.insert(available_servers, client_name)
            end
          end
        end
        return next(available_servers) == nil and icons.misc.NoActiveLsp
          or string.format("%s[%s]", icons.misc.LspAvailable, table.concat(available_servers, ", "))
      end,
      color = utils.gen_hl("blue", true, true, nil, "bold"),
      cond = conditionals.has_enough_room,
    },

    python_venv = {
      function()
        local function env_cleanup(venv)
          if string.find(venv, "/") then
            local final_venv = venv
            for w in venv:gmatch("([^/]+)") do
              final_venv = w
            end
            venv = final_venv
          end
          return venv
        end

        if vim.api.nvim_get_option_value("filetype", { scope = "local" }) == "python" then
          local venv = os.getenv("CONDA_DEFAULT_ENV")
          if venv then
            return icons.misc.PyEnv .. env_cleanup(venv)
          end
          venv = os.getenv("VIRTUAL_ENV")
          if venv then
            return icons.misc.PyEnv .. env_cleanup(venv)
          end
        end
        return ""
      end,
      color = utils.gen_hl("green", true, true),
      cond = conditionals.has_enough_room,
    },

    tabwidth = {
      function()
        return "󰌒 " .. vim.api.nvim_get_option_value("tabstop", { scope = "local" })
      end,
      padding = 1,
      cond = conditionals.has_enough_room,
    },

    cwd = {
      function()
        return icons.ui.FolderWithHeart .. utils.abbreviate_path(vim.fn.getcwd())
      end,
      color = utils.gen_hl("subtext0", true, true, nil, "bold"),
    },

    progress = {
      function()
        local cursorline = vim.fn.line(".")
        local cursorcol = vim.fn.virtcol(".")
        local filelines = vim.fn.line("$")
        local position
        if cursorline == 1 then
          position = "Top"
        elseif cursorline == filelines then
          position = "Bot"
        else
          position = string.format("%2d%%%%", math.floor(cursorline / filelines * 100))
        end
        return string.format("%s · %3d:%-2d", position, cursorline, cursorcol)
      end,
    },
  }

  require("lualine").setup({
    options = {
      icons_enabled = true,
      globalstatus = true,
      -- theme = custom_theme(),
      theme = "auto",
      component_separators = "",
      section_separators = { left = "", right = "" },
      disabled_filetypes = { statusline = { "alpha" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "filetype",
          colored = true,
          icon_only = false,
          icon = { align = "left" },
        },
        components.file_status,
        vim.tbl_extend("force", components.separator, {
          cond = function()
            return conditionals.has_git() and conditionals.has_filetype()
          end,
        }),
      },
      lualine_c = {
        {
          "branch",
          icon = icons.git_nosep.Branch,
          color = utils.gen_hl("subtext0", true, true, nil, "bold"),
          cond = conditionals.has_git,
        },
        {
          "diff",
          symbols = {
            added = icons.git.Add,
            modified = icons.git.Mod_alt,
            removed = icons.git.Remove,
          },
          source = diff_source,
          colored = false,
          color = utils.gen_hl("subtext0", true, true),
          cond = conditionals.has_git,
          padding = { right = 1 },
        },

        { utils.force_centering },
        components.macro,
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          sections = { "error", "warn", "info", "hint" },
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warning,
            info = icons.diagnostics.Information,
            hint = icons.diagnostics.Hint_alt,
          },
        },
        components.lsp,
      },
      lualine_x = {
        {
          "fileformat",
          symbols = {
            unix = "",
            dos = "",
            mac = "", -- Legacy macOS
          },
          padding = { left = 1 },
          cond = conditionals.has_enough_room,
        },
        {
          "encoding",
          fmt = string.upper,
          padding = { left = 1 },
          cond = conditionals.has_enough_room,
        },
        components.tabwidth,
      },
      lualine_y = {
        components.separator,
        components.python_venv,
        components.cwd,
      },
      lualine_z = { components.progress },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "quickfix", "toggleterm", "nvim-tree", "lazy", "mason" },
  })
end

return Plugin
