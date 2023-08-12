local M = {
  "folke/tokyonight.nvim",
  name = "tokyonight",
  opts = {
    -- storm, moon, night, day
    style = vim.g.eden_theme_variant or "night",
    transparent = vim.g.eden_transparent or false,
  },
}

if M.opts.transparent then
  M.opts.styles = {
    sidebars = "transparent",
    floats = "transparent",
  }
end

function M.config(_, opts)
  require(M.name).setup(opts)
  vim.cmd.colorscheme(M.name)
end

M.priority = 1000
M.lazy = vim.g.eden_theme ~= M.name

return M
