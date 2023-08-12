-- IDE-like sidebar for listing diagnostics, references, telescope results, quickfix, etc
-- https://github.com/folke/trouble.nvim

local M = {
  "folke/trouble.nvim",
  enabled = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "TroubleToggle", "Trouble" },
  opts = {
    use_diagnostic_signs = true,
  },
}

return M
