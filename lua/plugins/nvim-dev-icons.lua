-- Tools for getting nerd fonts icons by name, by file extension, and assigning them default highlight groups
-- https://github.com/nvim-tree/nvim-web-devicons

local M = {
  "nvim-tree/nvim-web-devicons",
  enabled = true,
  event = "VeryLazy",
}

function M.config()
  require("nvim-web-devicons").setup {
    override = {
      zsh = {
        icon = "",
        color = "#428850",
        cterm_color = "65",
        name = "Zsh",
      },
    },
    color_icons = true,
    default = true,
  }
end

return M
