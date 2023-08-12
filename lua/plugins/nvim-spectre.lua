-- Find & Replace plugin
-- Note: nvim-spectre doesn't support undo, so be sure to commit or save before replacing
-- https://github.com/nvim-pack/nvim-spectre

local M = {
  "nvim-pack/nvim-spectre",
  enabled = true,
  cmd = "Spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    color_devicons = true,
    open_cmd = "vnew",
    live_update = false, -- auto execute search again when you write to any file in vim
  },
}

return M
