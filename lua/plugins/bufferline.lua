-- Bufferline to show open buffers with neovim tabs integration
-- https://github.com/akinsho/bufferline.nvim

local M = {
  "akinsho/bufferline.nvim",
  enabled = true,
  event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "famiu/bufdelete.nvim",
  },
  opts = {
    options = {
      close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
      buffer_close_icon = "",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
      show_close_icon = false,
      show_buffer_close_icons = false,
    },
  },
}

function M.config(_, opts)
  require("bufferline").setup(opts)
end

return M
