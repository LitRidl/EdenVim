-- Navigate and manipulate files/directories by editing text buffers: create, delete, copy, rename, move
-- https://github.com/echasnovski/mini.files

local M = {
  "echasnovski/mini.files",
  enabled = true,

  opts = {
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },
    content = {
      filter = nil,
    },
    options = {
      use_as_default_explorer = true,
    },
  },

  keys = {
    {
      "<leader>fe",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files explorer (directory of current file)",
    },
    {
      "<leader>fE",
      function()
        require("mini.files").open(vim.loop.cwd(), true)
      end,
      desc = "Open mini.files explorer (cwd)",
    },
  },

  config = function(_, opts)
    require("mini.files").setup(opts)
  end,
}

return M
