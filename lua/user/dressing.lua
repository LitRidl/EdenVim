local M = {
  "stevearc/dressing.nvim",

  lazy = true,

  init = function()
    vim.ui.select = function(...)
      require("lazy").load { plugins = { "dressing.nvim" } }
      return vim.ui.select(...)
    end
    vim.ui.input = function(...)
      require("lazy").load { plugins = { "dressing.nvim" } }
      return vim.ui.input(...)
    end
  end,

  opts = {},

  config = function(_, opts)
    require("dressing").setup(opts)
  end,
}

return M
