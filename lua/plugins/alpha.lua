-- Greeter/dashboard plugin, actual theme and layout are in lua/settings/alpha-dashboard.lua
-- https://github.com/goolord/alpha-nvim

local M = {
  "goolord/alpha-nvim",
  enabled = true,
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config(_, opts)
  local dashboard = require "settings.alpha-dashboard"
  require("alpha").setup(dashboard.config)
end

return M
