local themes = {}

-- catppuccin
table.insert(themes, {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    -- latte, frappe, macchiato, mocha
    flavour = "mocha",
    integrations = {
      alpha = true,
      cmp = true,
      gitsigns = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      lsp_trouble = true,
      -- mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      -- navic = { enabled = true },
      -- neotest = true,
      -- noice = true,
      -- notify = true,
      nvimtree = true,
      semantic_tokens = true,
      telescope = true,
      treesitter = true,
      which_key = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
  end,
})

-- monokai-pro
table.insert(themes, {
  "loctvl842/monokai-pro.nvim",
  name = "monokai-pro",
  opts = {
    -- classic | octagon | pro | machine | ristretto | spectrum
    filter = "pro",
    background_clear = {},
  },
  config = function(_, opts)
    require("monokai-pro").setup(opts)
    require("lualine").setup({
      theme = "monokai-pro",
    })
  end,
})

-- tokyonight
table.insert(themes, {
  "folke/tokyonight.nvim",
  name = "tokyonight",
  config = function(_, opts)
    require("tokyonight").setup(opts)
  end,
})


-- Enable the theme specified in options.lua and disable all other themes
for _, v in pairs(themes) do
  v.priority = 1000
  v.cond = v.name == vim.g.eden_theme
  if v.cond then
    v.lazy = false
    v._config_base = v.config
    v.config = function(_, opts)
      -- _config_base may not be a function
      pcall(v._config_base, _, opts)
      vim.cmd.colorscheme(v.name)
    end
  end
end

return themes
