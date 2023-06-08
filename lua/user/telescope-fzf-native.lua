local M = {
  'nvim-telescope/telescope-fzf-native.nvim',
  build = 'make'
}

function M.init()
  local telescope = require("telescope")
  telescope.load_extension("fzf")
end

return M
