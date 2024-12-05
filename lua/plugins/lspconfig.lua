-- "Easy configuration" wrapper around builtin LSP (LspInfo, LspStop, multi-root support useful for memory-hungry LSP servers, etc)
-- Sets up each of `lsp_servers` from `lua/settings/toolset.lua`. Does NOT install any LSP servers, only configures them.
-- If you want to install LSP servers with Mason, check `lsp_mason_install` in `lua/settings/toolset.lua` and
-- `lua/plugins/mason.lua` instead.
-- https://github.com/neovim/nvim-lspconfig

local M = {
  "neovim/nvim-lspconfig",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- Package manager: install and manage LSP servers, DAP servers, linters, and formatters
    -- https://github.com/williamboman/mason.nvim
    {
      "williamboman/mason.nvim",
      enabled = vim.g.mason_enabled,
    },
    -- Source for neovim builtin LSP client
    -- https://github.com/hrsh7th/cmp-nvim-lsp
    "hrsh7th/cmp-nvim-lsp",
    -- Signature help, docs and completion for the nvim Lua API
    -- https://github.com/folke/neodev.nvim
    "folke/neodev.nvim",
    -- Schemas are used in lua/settings/{jsonls.lua,yamlls.lua}
    -- To add your own schemas, refer to https://github.com/b0o/SchemaStore.nvim
    "b0o/schemastore.nvim",
  },
  opts = {
    inlay_hints = {
      enabled = true,
      -- exclude = { "vue" },     -- filetypes for which you don't want to enable inlay hints
    },
  },
}

function M.config(_, opts)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local lspconfig = require "lspconfig"
  local on_attach = function(client, bufnr)
    require("illuminate").on_attach(client)
  end

  -- Try to configure each LSP server from `lua/settings/toolset.lua` with options in `settings/{server}.lua`, if present
  for _, server in pairs(require("settings.toolset").lsp_servers) do
    server_opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    server = vim.split(server, "@")[1]

    -- Load custom LSP server configuration from `settings/{server}.lua` file
    local require_ok, conf_opts = pcall(require, "settings." .. server)
    if require_ok then
      server_opts = vim.tbl_deep_extend("force", conf_opts, server_opts)
    end

    -- You can manually add extra LSP server configurations here, if you don't want to use `settings/{server}.lua`
    lspconfig[server].setup(server_opts)
  end

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local diagnostics = {
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      suffix = "",
    },
  }

  vim.diagnostic.config(diagnostics)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
