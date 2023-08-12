-- null-ls sources are able to hook into the following LSP features like code actions, formatting, diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim

local M = {
  "jose-elias-alvarez/null-ls.nvim",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
  },
}

function M.config()
  local null_ls = require "null-ls"
  -- local formatting = null_ls.builtins.formatting
  -- local diagnostics = null_ls.builtins.diagnostics

  -- Be sure to install all programs listed here -- if you see them here, they are not available in mason-null-ls
  null_ls.setup {
    debug = false,
    -- If mason-null-ls is enabled (see lua/plugins/mason), use `sources` only for packages
    -- not supported by mason. Packages below are given as an example, they are supported by mason-null-ls
    -- sources = {
    --   formatting.prettier,
    --   diagnostics.ruff,
    --   formatting.stylua,
    -- },
  }
end

return M
