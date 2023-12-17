local M = {
  "navarasu/onedark.nvim",
  name = "onedark",
  opts = {
    -- dark, darker, cool, deep, warm, warmer, light
    style = vim.g.eden_theme_variant or "dark",
    transparent = vim.g.eden_transparent or false,
    lualine = {
      transparent = true,
    },
  },
}

function M.config(_, opts)
  require(M.name).setup(opts)
  vim.cmd.colorscheme(M.name)
end

M.priority = 1000
M.lazy = vim.g.eden_theme ~= M.name

return M
