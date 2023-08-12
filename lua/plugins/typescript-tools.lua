-- A more performant replacement for typescript.nvim and typescript-language-server
-- https://github.com/pmizio/typescript-tools.nvim

local M = {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
}

return M
