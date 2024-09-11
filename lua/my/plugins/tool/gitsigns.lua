--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│ MODULE: my.plugins.ui.gitsigns                                           │--
--│ DESC: git decorations                                                    │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

Plugin.config = function()

  local function on_attach(bufnr)
    local gs = package.loaded.gitsigns
    local map = vim.keymap.set
    local function opts(desc)
      local options = { desc = "Git: " .. desc, buffer = bufnr, noremap = true, silent = true }
      return options
    end

    -- Navigation
    map("n", "]h", function()
      if vim.wo.diff then return "]h" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { desc = "Next hunk", buffer = bufnr, expr = true })

    map("n", "[h", function()
      if vim.wo.diff then return "[h" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { desc = "Previous hunk", buffer = bufnr, expr = true })

    -- Actions
    map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", opts("Stage hunk"))
    map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts("Reset hunk"))
    map("n", "<leader>gu", gs.undo_stage_hunk, opts("Undo stage hunk"))
    map("n", "<leader>gp", gs.preview_hunk_inline, opts("Preview hunk"))
    map("n", "<leader>gP", gs.preview_hunk, opts("Preview hunk inline"))
    map("n", "<leader>gS", gs.stage_buffer, opts("Stage buffer"))
    map("n", "<leader>gR", gs.reset_buffer, opts("Reset buffer"))
    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, opts("Blame line"))
    map("n", "<leader>gd", gs.diffthis, opts("Diff this"))
    map("n", "<leader>gD", function() gs.diffthis("~") end, opts("Diff this against parent"))

    map("n", "<leader>tb", gs.toggle_current_line_blame, opts("Blame line"))
    map("n", "<leader>td", gs.toggle_deleted, opts("Git deleted"))
  end

  require("gitsigns").setup({
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    auto_attach = true,
    signcolumn = true,
    sign_priority = 6,
    update_debounce = 100,
    word_diff = false,
    current_line_blame = true,
    diff_opts = { internal = true },
    watch_gitdir = { interval = 1000, follow_files = true },
    current_line_blame_opts = { delay = 1000, virt_text = true, virtual_text_pos = "eol" },

    on_attach = on_attach,

  })
end

return Plugin
