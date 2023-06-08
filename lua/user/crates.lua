M =   {
  "Saecki/crates.nvim",
  init = function()
    vim.api.nvim_create_autocmd("BufRead", {
      group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
      pattern = "Cargo.toml",
      callback = function()
        require("cmp").setup.buffer { sources = { { name = "crates" } } }
        require "crates"
      end,
    })
  end,
  opts = {
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  },
}

return M
