-- Package manager: install and manage LSP servers, DAP servers, linters, and formatters
-- https://github.com/williamboman/mason.nvim

local M = {
  {
    "williamboman/mason.nvim",
    enabled = vim.g.mason_enabled,
    cmd = "Mason",
    build = ":MasonUpdate",
    dependencies = {
      -- Ensure automatic installation of lsp packages in settings/toolset.lua
      -- https://github.com/williamboman/mason-lspconfig.nvim
      "williamboman/mason-lspconfig.nvim",
    },
    event = "BufReadPre",
    opts = {
      ui = {
        border = "none",
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " 󰚌",
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup {
        ensure_installed = require("settings.toolset").lsp_servers,
        -- Not related to ensure_installed. If servers are set up via nvim-lspconfig, but not installed, it tries to install them
        automatic_installation = false,
      }
    end,
  },

  {
    -- Integrates mason with null-ls -- first of all, it gives automatic installation of null-ls items
    -- https://github.com/jay-babu/mason-null-ls.nvim
    "jay-babu/mason-null-ls.nvim",
    enabled = vim.g.mason_enabled,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-null-ls").setup {
        ensure_installed = require("settings.toolset").null_ls,
        -- Aautomatically install mason-available tools based on sources in `null-ls`.
        automatic_installation = false,
        handlers = {},
      }
      -- Please add packages not supported by mason to lua/plugins/null-ls.lua, key `sources`
    end,
  },
}

return M
