-- Code outline view (symbol explorer)
-- https://github.com/stevearc/aerial.nvim

local M = {
  "stevearc/aerial.nvim",
  enabled = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  -- event = "BufEnter",
  cmd = { "AerialToggle", "AerialOpen", "AerialInfo", "AerialOpen", "AerialOpenAll", "AerialNavToggle", "AerialNavOpen" },
  opts = {
    attach_mode = "global",
    backends = { "lsp", "treesitter", "markdown", "man" },
    layout = { min_width = 28 },
    show_guides = true,
    filter_kind = false,
    guides = {
      mid_item = "├ ",
      last_item = "└ ",
      nested_top = "│ ",
      whitespace = "  ",
    },
  },
}

M.config = function(_, opts)
  require("aerial").setup(opts)
end

return M
