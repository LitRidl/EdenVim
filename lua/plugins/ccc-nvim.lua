-- Color picker and highlighter
-- https://github.com/uga-rosa/ccc.nvim

local M = {
  "uga-rosa/ccc.nvim",
  enabled = true,
  cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
  -- If you use these features often, consider adding keymaps
  -- keys = {
  --   { "<leader>zh", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle color highlighting" },
  --   { "<leader>zc", "<cmd>CccConvert<cr>", desc = "Convert color" },
  --   { "<leader>zp", "<cmd>CccPick<cr>", desc = "Pick Color" },
  -- },
  opts = {
    highlighter = {
      auto_enable = true,
      lsp = true,
      excludes = { "lazy", "mason", "help", "neo-tree" },
    },
  },
}

function M.config(_, opts)
  require("ccc").setup(opts)
  if opts.highlighter and opts.highlighter.auto_enable then
    vim.cmd.CccHighlighterEnable()
  end
end

return M
