-- Commands to delete a buffer without messing up window layout
-- https://github.com/famiu/bufdelete.nvim

local M = {
  "famiu/bufdelete.nvim",
  enabled = true,
  cmd = { "Bdelete", "Bwipeout" },
}

return M
