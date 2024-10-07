--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.coding.nvim-cmp                                      │--
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
    "hrsh7th/cmp-nvim-lsp", -- for lsp completion
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "L3MON4D3/LuaSnip", -- snippet engine
    "rafamadriz/friendly-snippets",  -- some snippets collection
  }
}

Plugin.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local types = require("cmp.types")
  local compare = require("cmp.config.compare")
  local util = require("my.helpers.utils")
  local icons = {
    kind = require("my.helpers.icons").get("kind"),
    type = require("my.helpers.icons").get("type"),
    cmp = require("my.helpers.icons").get("cmp"),
  }

  -- luasnip setup
  require("luasnip/loaders/from_vscode").lazy_load()  -- load snippets collection from plugins

  ---@type table<integer, integer>
  local modified_priority = {
    [types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
    [types.lsp.CompletionItemKind.Snippet] = 0, -- top
    [types.lsp.CompletionItemKind.Keyword] = 0, -- top
    [types.lsp.CompletionItemKind.Text] = 100, -- bottom
  }
  ---@param kind integer: kind of completion entry
  local function modified_kind(kind)
    return modified_priority[kind] or kind
  end

  -- cmp setup
  cmp.setup({
    preselect = cmp.PreselectMode.None,
    sources = cmp.config.sources({  -- sources for autocompletion
      { name = "nvim_lsp", keyword_length = 3 },  -- lsp
      { name = "luasnip" }, -- snippets
      { -- text within current buffer
        name = "buffer",
        option = {
          keyword_length = 3,
          get_bufnrs = function() -- from all buffers (less than 1MB)
            local bufs = {}
            for _, bufn in ipairs(vim.api.nvim_list_bufs()) do
              local buf_size = vim.api.nvim_buf_get_offset(bufn, vim.api.nvim_buf_line_count(bufn))
              if buf_size < 10 * 1024 then
                table.insert(bufs, bufn)
              end
            end
            return bufs
          end,
        },
      },
      { -- file system paths
        name = "path",
        option = {
          get_cwd = function(params)
            return { vim.fn.expand(("#%d:p:h"):format(params.context.bufnr)), vim.fn.getcwd()
            }
          end,
        },
      }
    }),
    snippet = { -- configure how nvim-cmp interacts with snippet engine
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        compare.offset,
        compare.exact,
        function(entry1, entry2) -- sort by length ignoring "=~"
          local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()_]", ""))
          local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()_]", ""))
          if len1 ~= len2 then
            return len1 - len2 < 0
          end
        end,
        compare.recently_used, ---@diagnostic disable-line
        function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
          local kind1 = modified_kind(entry1:get_kind())
          local kind2 = modified_kind(entry2:get_kind())
          if kind1 ~= kind2 then
            return kind1 - kind2 < 0
          end
        end,
        function(entry1, entry2) -- score by lsp, if available
          local t1 = entry1.completion_item.sortText
          local t2 = entry2.completion_item.sortText
          if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
            return t1 < t2
          end
        end,
        compare.score,
        compare.order,
      },
    },
    matching = {
      disallow_fuzzy_matching = false, -- fmodify -> fnamemodify
      disallow_fullfuzzy_matching = true,
      disallow_partial_fuzzy_matching = true,
      disallow_partial_matching = false, -- fb -> foo_bar
      disallow_prefix_unmatching = true, -- bar -> foo_bar 
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
    window = {
      completion = {
        -- border = util.set_colorborder("CmpBorder"),
        side_padding = 0,
        col_offset = -3,
        scrollbar = false,
        winhighlight = "Normal:Pmenu,CursorLine:CmpSel,Search:None",
      },
      documentation = {
        border = util.set_colorborder("CmpDocBorder"),
        winhighlight = "Normal:CmpDoc,Search:None",
      },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    performance = {
      debounce = 60,
      throttle = 30,
      fetching_timeout = 500,
      confirm_resolve_timeout = 80,
      async_budget = 1,
      max_view_entries = 200,
    },
    experimental = {
      ghost_text = false, -- { hl_group = "Whitespace" },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-y>"] = cmp.config.disable,
      ["<C-e>"] = cmp.config.disable,
      ["<C-c>"] = cmp.mapping.complete(), -- show completion suggestionscmp
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
      -- ["<Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      --   elseif luasnip.expand_or_jumpable() then
      --     luasnip.expand_or_jump()
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
      -- ["<S-Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      --   elseif luasnip.jumpable(-1) then
      --     luasnip.jump(-1)
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
      -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
      { name = "cmdline" },
      { name = "path" },
    }
  })
end

return Plugin
