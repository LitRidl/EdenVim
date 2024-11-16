local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    -- latte, frappe, macchiato, mocha
    flavour = vim.g.eden_theme_variant or "mocha",
    transparent_background = vim.g.eden_transparent or false,
    integrations = {
      alpha = true,
      aerial = true,
      flash = true,
      dap = {
        enabled = true,
        enable_ui = true,
      },
      cmp = true,
      gitsigns = true,
      illuminate = true,
      show_end_of_buffer = false,
      indent_blankline = { enabled = true },
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      neotest = true,
      nvimtree = true,
      semantic_tokens = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
  },
}

function M.config(_, opts)
  require(M.name).setup(opts)
  vim.cmd.colorscheme(M.name)
end

M.priority = 1000
M.lazy = vim.g.eden_theme ~= M.name

return M
