-- Colors for manual Gruvbox theme override
local neutral_aqua = "#689d6a"
local bright_yellow = "#fadb2f"
local dark4 = "#7c6f64"
local neutral_yellow = "#d79921"
local bright_orange = "#fe8019"

local M = {
  "ellisonleao/gruvbox.nvim",
  name = "gruvbox",
  opts = {
    -- hard, soft, "" (the default contrast)
    contrast = vim.g.eden_theme_variant or "hard",
    transparent_mode = vim.g.eden_transparent or false,
    overrides = {
      TabLine = { fg = neutral_aqua },
      TabLineSel = { fg = neutral_aqua },

      BufferlineBufferSelected = { fg = neutral_aqua, bold = true, italic = true },
      BufferlineSeparator = { fg = neutral_aqua },
      BufferlineSeparatorSelected = { fg = bright_yellow },

      BufferlineTab = { fg = dark4 },
      BufferlineTabSelected = { fg = neutral_aqua, bold = true, italic = true },
      BufferlineTabSeparator = { fg = dark4 },
      BufferlineTabSeparatorSelected = { fg = dark4 },

      -- Uncomment to make window separator green (for some people it's too much color in UI)
      -- WinSeparator = { fg = neutral_aqua },

      FlashLabel = { fg = bright_orange, bold = true },
      WhichKeySeparator = { fg = neutral_yellow },
      WhichKey = { fg = bright_yellow },
      WhichKeyDesc = { fg = neutral_aqua },
      WhichKeyGroup = { fg = bright_orange },
      WhichKeyBorder = { fg = neutral_aqua },

      NvimTreeRootFolder = { fg = neutral_aqua },
    },
  },
}

function M.config(_, opts)
  require(M.name).setup(opts)
  vim.cmd.colorscheme(M.name)
end

M.priority = 1000
M.lazy = vim.g.eden_theme ~= M.name

return M
