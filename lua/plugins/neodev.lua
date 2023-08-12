-- Signature help, docs and completion for the nvim Lua API
-- https://github.com/folke/neodev.nvim

M = {
  "folke/neodev.nvim",
  enabled = true,
  ft = { "lua" },
}

function M.config()
  require("neodev").setup({
    library = {
      plugins = { "nvim-dap-ui" },
      types = true,
    },
  })
end

return M
