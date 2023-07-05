local M = {
  "echasnovski/mini.files",

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
      "<leader>fm",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (directory of current file)",
    },
    {
      "<leader>fM",
      function()
        require("mini.files").open(vim.loop.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },

  config = function(_, opts)
    require("mini.files").setup(opts)
  end,
}

return M
