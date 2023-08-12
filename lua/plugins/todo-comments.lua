-- Highlight, list and search TODO/HACK/BUG/WARN/PERF/etc comments
-- https://github.com/folke/todo-comments.nvim

local M = {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  config = true,
}

return M
