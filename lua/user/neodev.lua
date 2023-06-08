-- M =   {
--   "neovim/nvim-lspconfig",
--   -- This is a hack needed for neodev to work! (it provides lua type hinting)
--   dependencies = "folke/neodev.nvim",
-- }

M = {
  "folke/neodev.nvim",
}

-- function M.config()
--   require("neodev").setup({
--     library = {
--       plugins = { "nvim-dap-ui" },
--       types = true,
--     },
--   })
-- end

return M
