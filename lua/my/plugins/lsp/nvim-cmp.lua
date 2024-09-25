--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.lsp.nvim-cmp                                         │--
--│  DETAIL: Auto-completion engine                                          │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-08-08 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-cmdline",  -- source for command line
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "L3MON4D3/LuaSnip", -- snippet engine
    "rafamadriz/friendly-snippets",  -- some snippets collection
    "lukas-reineke/cmp-under-comparator",
    "hrsh7th/cmp-nvim-lsp", -- for lsp completion
  }
}

Plugin.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local util = require("my.helpers.utils")
  local icons = {
    kind = require("my.helpers.icons").get("kind"),
    type = require("my.helpers.icons").get("type"),
    cmp = require("my.helpers.icons").get("cmp"),
  }

  -- luasnip setup
  require("luasnip/loaders/from_vscode").lazy_load()  -- load snippets collection from plugins

  local compare = require("cmp.config.compare")
  compare.lsp_scores = function(entry1, entry2)
    local diff
    if entry1.completion_item.score and entry2.completion_item.score then
      diff = (entry2.completion_item.score * entry2.score) - (entry1.completion_item.score * entry1.score)
    else
      diff = entry2.score - entry1.score
    end
    return (diff < 0)
  end

  local comparators = {
    compare.offset, -- Items closer to cursor will have lower priority
    compare.exact,
    -- compare.scopes,
    compare.lsp_scores,
    compare.sort_text,
    compare.score,
    compare.recently_used,
    -- compare.locality, -- Items closer to cursor will have higher priority, conflicts with `offset`
    require("cmp-under-comparator").under,
    compare.kind,
    compare.length,
    compare.order,
  }

  -- cmp setup
  cmp.setup({
    preselect = cmp.PreselectMode.None,
    window = {
      completion = {
        -- border = util.set_colorborder("CmpBorder"),
        side_padding = 0,
        col_offset = -3,
        scrollbar = false,
        winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel,Search:None",
      },
      documentation = {
        border = util.set_colorborder("CmpDocBorder"),
        winhighlight = "Normal:CmpDoc,Search:None",
      },
    },
    sources = cmp.config.sources({  -- sources for autocompletion
      { name = "nvim_lsp" },  -- lsp
      { name = "luasnip" }, -- snippets
      { name = "buffer" }, -- text within current buffer
      { name = "path" }, -- file system paths
    }),
    snippet = { -- configure how nvim-cmp interacts with snippet engine
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sorting = {
      priority_weight = 2,
      comparators = comparators,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local lspkind_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp)
        -- vim_item.menu = string.format(" (%s)", vim_item.kind)
        vim_item.kind = string.format(" %s ", lspkind_icons[vim_item.kind] or icons.cmp.undefined)
        vim_item.menu = setmetatable({
          buffer = "│ BUF",
          nvim_lsp = "│ LSP",
          path = "│ PATH",
          luasnip = "│ SNIP",
          cmdline = "│ CMD",
          }, {
            __index = function()
              return "│ NVIM" -- builtin/unknown source names
            end,
        })[entry.source.name]

        local label = vim_item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, 80)
        if truncated_label ~= label then
          vim_item.abbr = truncated_label .. "..."
        end

        -- deduplicate results from nvim_lsp
        if entry.source.name == "nvim_lsp" then
          vim_item.dup = 0
        end

        return vim_item
      end,
    },
    matching = {
      disallow_partial_fuzzy_matching = false,
    },
    performance = {
      async_budget = 1,
      max_view_entries = 120,
    },
    experimental = {
      ghost_text = {
        hl_group = "Whitespace",
      },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-y>"] = cmp.config.disable,
      ["<C-e>"] = cmp.config.disable,
      ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      ["<C-h>"] = cmp.mapping.abort(), -- close completion window
      ["<C-l>"] = cmp.mapping.confirm({ select = true }), -- confirm suggestions
      ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<C-d>"] = cmp.mapping.scroll_docs(4), -- scroll down docs
      ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- scroll up docs
      ["<C-f>"] = cmp.mapping(function() -- jump forward inside snippets
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { "i", "s" }),
      ["<C-b>"] = cmp.mapping(function() -- jump backward inside snippets
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { "i", "s" }),
      -- regular tab completion
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    })
  })

  -- cmp-cmdline setup
  local cmdline_mapping = {
    ["<C-z>"] = { c = cmp.config.disable, },
    ["<C-y>"] = { c = cmp.config.disable, },
    ["<C-e>"] = { c = cmp.config.disable, },
    ["<C-h>"] = { c = cmp.mapping.abort() }, -- quit completion window
    ["<C-l>"] = { c = cmp.mapping.confirm({ select = true }) }, -- insert suggestions
    ["<C-j>"] = { c = cmp.mapping.select_next_item() }, -- next suggestion
    ["<C-k>"] = { c = cmp.mapping.select_prev_item() }, -- previous suggestion
  }
  -- "/", "?" cmdline setup.
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
    sources = {
      { name = "buffer" }
    }
  })
  -- ":" cmdline setup.
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
    sources = {
      { name = "path" },
      { name = "cmdline" }
    }
  })
end

return Plugin
