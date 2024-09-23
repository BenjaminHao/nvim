--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.plugins.editor.rainbow-delimiters                            │--
--│  DETAIL: Parentheses highlighting                                        │--
--│  CREATE: 2024-09-19 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-19 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Plugin = {
  "hiphish/rainbow-delimiters.nvim",
}

Plugin.config = function()
  ---@param threshold number @Use global strategy if nr of lines exceeds this value
  local function init_strategy(threshold)
    return function()
      -- Disable on very large files
      local line_count = vim.api.nvim_buf_line_count(0)
      if line_count > 7500 then
        return nil
      end

      -- Disable on parser error
      local errors = 200
      vim.treesitter.get_parser():for_each_tree(function(lt)
        if lt:root():has_error() and errors >= 0 then
          errors = errors - 1
        end
      end)
      if errors < 0 then
        return nil
      end

      return line_count > threshold and require("rainbow-delimiters").strategy["global"]
        or require("rainbow-delimiters").strategy["local"]
    end
  end

  require('rainbow-delimiters.setup').setup {
    strategy = {
      [""] = init_strategy(500),
      c = init_strategy(300),
      cpp = init_strategy(300),
      lua = init_strategy(500),
      vimdoc = init_strategy(300),
      vim = init_strategy(300),
    },
    query = {
      [""] = "rainbow-delimiters",
      latex = "rainbow-blocks",
      javascript = "rainbow-delimiters-react",
    },
    highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterOrange",
      "RainbowDelimiterYellow",
      "RainbowDelimiterGreen",
      "RainbowDelimiterBlue",
      "RainbowDelimiterCyan",
      "RainbowDelimiterViolet",
    },
  }
end

return Plugin
