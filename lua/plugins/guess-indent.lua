local M = {
  enabled = true,
  "nmac427/guess-indent.nvim",
}

function M.config()
  require("guess-indent").setup {}
end

return M
