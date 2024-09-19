-- Tools for getting nerd fonts icons by name, by file extension, and assigning them default highlight groups
-- Previously it was https://github.com/nvim-tree/nvim-web-devicons and lots of plugins still depend on it
-- To avoid conflict, mini.icons, which is generally better, can mock nvim-web-devicons as seen in M.init below
-- https://github.com/echasnovski/mini.icons

local M = {
  "echasnovski/mini.icons",
  enabled = true,
  lazy = false,
  -- Can be customized like this:
  -- opts = {
  --   file = {
  --     [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
  --     ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
  --   },
  --   filetype = {
  --     dotenv = { glyph = "", hl = "MiniIconsYellow" },
  --   },
  -- },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}

return M
