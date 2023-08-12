local M = {
  "stevearc/dressing.nvim",
  enabled = true,
}

function M.init()
  vim.ui.select = function(...)
    require("lazy").load { plugins = { "dressing.nvim" } }
    return vim.ui.select(...)
  end
  vim.ui.input = function(...)
    require("lazy").load { plugins = { "dressing.nvim" } }
    return vim.ui.input(...)
  end
end

function M.config(_, opts)
  require("dressing").setup(opts)
end

return M
