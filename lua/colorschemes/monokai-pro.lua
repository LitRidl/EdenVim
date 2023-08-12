local M = {
  "loctvl842/monokai-pro.nvim",
  name = "monokai-pro",
  opts = {
    -- classic, octagon, pro, machine, ristretto, spectrum
    filter = vim.g.eden_theme_variant or "spectrum",
    transparent_background = vim.g.eden_transparent,
    background_clear = {},
    devicons = true,
  },
}

function M.config(_, opts)
  require(M.name).setup(opts)
  vim.cmd.colorscheme(M.name)
end

M.priority = 1000
M.lazy = vim.g.eden_theme ~= M.name

return M
