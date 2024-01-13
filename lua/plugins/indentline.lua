-- Adds indentation guides to all lines (including empty lines)
-- https://github.com/lukas-reineke/indent-blankline.nvim

local M = {
  "lukas-reineke/indent-blankline.nvim",
  enabled = true,
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = "│" },
    exclude = {
      buftypes = {
        "nofile",
        "terminal",
        "quickfix",
        "prompt",
      },
      filetypes = {
        "help",
        "startify",
        "aerial",
        "alpha",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "text",
        "neo-tree",
        "Trouble",
      },
    },
  },
}

return M
