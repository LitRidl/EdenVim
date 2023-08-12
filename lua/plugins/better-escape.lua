-- Rapidly type 'jk' or 'jj' in Insert mode to go back to the Normal mode
-- https://github.com/max397574/better-escape.nvim

local M = {
  "max397574/better-escape.nvim",
  enabled = true,
  event = "InsertCharPre",
  opts = {
    mapping = { "jk", "jj" },
    -- Decrease timeout if you type very fast and experience false positives
    timeout = 150,
  },
}

return M
