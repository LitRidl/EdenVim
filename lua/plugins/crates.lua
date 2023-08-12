-- Complete rust crate versions, upgrade them, open crate docs in a floating window, show dependencies, etc
-- Note: the plugin is feature-rich, but most of them are workflow-specific. Better design keymaps on your own.
-- For example, require("crates").open_documentation() opens crate documentation. Or you can upgrade all crates at once.
-- https://github.com/Saecki/crates.nvim

M = {
  "Saecki/crates.nvim",
  enabled = true,
  event = { "BufRead Cargo.toml" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  },
}

function M.init()
  -- Lazy support of cmp-based autocompletion (instead of hard-coding in lua/plugins/cmp.lua in opts.sources)
  vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
    pattern = "Cargo.toml",
    callback = function()
      require("cmp").setup.buffer { sources = { { name = "crates" } } }
      require "crates"
    end,
  })
end

return M
