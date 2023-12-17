-- Displays a popup with possible key bindings of the command you started typing
-- https://github.com/folke/which-key.nvim

local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto & surround" },
      ["z"] = { name = "+folds & centering & spelling" },
      ["gz"] = { name = "+surround" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader><leader>"] = { name = "+swap buffers" },
      ["<tab>"] = { name = "+tabpages" },
      ["<leader>d"] = { name = "+debug" },
      ["<leader>f"] = { name = "+find & files" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+git hunks navigation" },
      ["<leader>l"] = { name = "+lsp" },
      ["<leader>s"] = { name = "+session" },
      ["<leader>t"] = { name = "+terminal" },
      ["<leader>t2"] = { name = "+second terminal" },
      ["<leader>u"] = { name = "+ui & toggling (wordwrap, etc)" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
    },
    icons = {
      separator = "󱦰", -- symbol used between a key and it's label
      -- breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      -- group = "+", -- symbol prepended to a group
    },
    window = {
      -- If it's difficult to distinguish which-key popup from the background, uncomment this
      -- border = "single",
    },
  },
}

function M.config(_, opts)
  require("which-key").setup(opts)
  local wk = require "which-key"
  wk.setup(opts)
  wk.register(opts.defaults)
end

return M
