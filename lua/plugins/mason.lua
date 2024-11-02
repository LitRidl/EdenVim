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

      -- Attempt to install LSP servers available through Mason: try every server in lsp_servers from settings/toolset.lua,
      -- except those defined in lsp_with_no_mason (i.e., lsp_with_no_mason is subtracted from lsp_servers)
      local settings = require("settings.toolset")
      require("mason-lspconfig").setup {
          ensure_installed = vim.tbl_filter(
            function(server)
              return not vim.tbl_contains(settings.lsp_with_no_mason, server)
            end,
            settings.lsp_servers
          ),
        -- Not related to ensure_installed. If servers are set up via nvim-lspconfig, but not installed, it tries to install them
        automatic_installation = false,
      }
    end,
  },

  {
    -- Integrates mason with null-ls -- it gives automatic installation of null-ls items
    -- NOTE: when referring to null-ls, it is actually none-ls as null-ls is not maintained anymore
    -- https://github.com/jay-babu/mason-null-ls.nvim
    "jay-babu/mason-null-ls.nvim",
    enabled = vim.g.mason_enabled,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-null-ls").setup {
        -- Using null-ls as a primary source of truth to enable an option of not using mason
        -- When mason is disabled -- recommended for Nix/NixOS -- null-ls will still work,
        -- it just won't use tool auto-installation of mason
        -- https://github.com/jay-babu/mason-null-ls.nvim?tab=readme-ov-file#setup
        ensure_installed = nil,
        -- Automatically install mason-available tools based on sources in `null-ls`.
        automatic_installation = true,
        handlers = {
          -- Exclude builtins that don't have corresponding Mason packages
          gitsigns = function() end,
          printenv = function() end,
          -- Add other builtins to exclude as needed
        },
      }
      -- Please add packages not supported by mason to lua/plugins/null-ls.lua, key `sources`
    end,
  },
}

return M
