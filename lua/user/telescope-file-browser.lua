local M = {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
}

function M.init()
  local telescope = require("telescope")
  telescope.load_extension("file_browser")
end

return M
