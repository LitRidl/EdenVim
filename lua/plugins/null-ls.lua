-- null-ls sources are able to hook into the following LSP features like code actions, formatting, diagnostics
-- NOTE: when referring to null-ls, it is actually none-ls as null-ls is not maintained anymore
-- https://github.com/nvimtools/none-ls.nvim (original: jose-elias-alvarez/null-ls.nvim)

local M = {
  "nvimtools/none-ls.nvim",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "williamboman/mason.nvim",
      enabled = vim.g.mason_enabled,
    }
  },
}

function M.config()
  local null_ls = require "null-ls"

  -- Be sure to make all programs listed here available if you have Mason disabled
  null_ls.setup {
    debug = false,
    sources = require("settings.toolset").null_ls_sources(null_ls),
  }
end

return M
