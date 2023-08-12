-- Visualizes indent scope, adds ii and ai "same indent" text object, [i and ]i indent motions "go to top/bottom"
-- https://github.com/echasnovski/mini.indentscope

local M = {
  "echasnovski/mini.indentscope",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    symbol = "│",
    options = { try_as_border = true },
  },
}

function M.init()
  vim.api.nvim_create_autocmd("FileType", {
    -- Not all of these are filetypes, actually
    pattern = {
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
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
end

function M.config(_, opts)
  require("mini.indentscope").setup(opts)
end

return M
