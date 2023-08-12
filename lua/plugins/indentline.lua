-- Adds indentation guides to all lines (including empty lines)
-- https://github.com/lukas-reineke/indent-blankline.nvim

local M = {
  "lukas-reineke/indent-blankline.nvim",
  enabled = true,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    char = "│",
    show_trailing_blankline_indent = false,
    show_current_context = false,
    filetype_exclude = {
      "help",
      "man",
      "lspinfo",
      "nofile",
      "spectre_panel",
      "terminal",
      "telescope",
      "alpha",
      "dashboard",
      "terminal",
      "lazy",
      "mason",
      "dirvish",
      "fugitive",
      "alpha",
      "NvimTree",
      "neo-tree",
      "packer",
      "neogitstatus",
      "Trouble",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "lazyterm",
      "DressingSelect",
      "TelescopePrompt",
    },
  },
}

return M
