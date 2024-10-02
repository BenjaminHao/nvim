--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.ui.alpha                                             │--
--│  DETAIL: Startup screen plugin                                           │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
-- TODO: icons
local Plugin = {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}

Plugin.config = function()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  -- Set header
  dashboard.section.header.val = require("my.configs.settings").dashboard_image
  dashboard.section.header.opts.hl = "AlphaHeader"

  -- Set menu
  dashboard.section.buttons.val = {
    dashboard.button("n", "󰈔 " .. " New File", "<cmd>ene <bar> startinsert<cr>"),
    dashboard.button("f", "󰈞 " .. " Find File", function () require("my.keymaps.func").find_files() end),
    dashboard.button("r", "󰈙 " .. " Recent File", function () require("my.keymaps.func").find_recent() end),
    dashboard.button("w", "󱎸 " .. " Find Word", function () require("my.keymaps.func").find_word() end),
    dashboard.button("e", "󰙅 " .. " Explorer", "<cmd>NvimTreeOpen<cr>"),
    dashboard.button("c", " " .. " Config" , "<cmd>e $MYVIMRC|cd %:p:h|Neotree<cr>"),
    dashboard.button("h", "󰗶 " .. " Checkhealth", "<cmd>Lazy load all | checkhealth<cr>"),
    dashboard.button("q", " " .. " Quit", "<cmd>qa!<cr>"),
  }
  for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
  end

  -- Set footer
  local function footer()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    return "   eovim"
      .. "   "
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch
      .. "  󰏓 "
      .. stats.count
      .. " plugins in "
      .. ms
      .. "ms"
  end

  dashboard.section.footer.val = footer()
  dashboard.section.footer.opts.hl = "AlphaFooter"

  -- Padding
  local head_butt_padding = 2
  local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
  local header_padding = math.max(0, math.ceil((vim.fn.winheight(0) - occu_height) * 0.25))
  local foot_butt_padding = 1

  dashboard.config.layout = {
    { type = "padding", val = header_padding },
    dashboard.section.header,
    { type = "padding", val = head_butt_padding },
    dashboard.section.buttons,
    { type = "padding", val = foot_butt_padding },
    dashboard.section.footer,
  }

  -- Send config to alpha
  alpha.setup(dashboard.opts)

  ------------------------------ Autocmds ------------------------------------
  local autocmd = vim.api.nvim_create_autocmd
  local alphaaugroup = vim.api.nvim_create_augroup("Alpha", { clear = true })

  autocmd("User", {
    desc = "Set footer with loading time",
    group = alphaaugroup,
    pattern = "LazyVimStarted",
    callback = function()
      dashboard.section.footer.val = footer()
      pcall(vim.cmd.AlphaRedraw)
    end,
  })

  autocmd("User", {
    desc = "Disable folding on alpha buffer",
    group = alphaaugroup,
    pattern = "AlphaReady",
    callback = function ()
      vim.opt_local.foldenable = false
    end
  })

  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    autocmd("User", {
      desc = "Load dashboard after Lazy installing plugins",
      group = alphaaugroup,
      pattern = "AlphaReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end
end

return Plugin
