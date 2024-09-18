-- "Easy configuration" wrapper around builtin LSP (LspInfo, LspStop, multi-root support useful for memory-hungry LSP servers, etc)
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
}

function M.config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)

  local lspconfig = require "lspconfig"
  local on_attach = function(client, bufnr)
    require("illuminate").on_attach(client)
  end

  for _, server in pairs(require("settings.toolset").lsp_servers) do
    Opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "settings." .. server)
    if require_ok then
      Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
    end

    lspconfig[server].setup(Opts)
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

  local config = {
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

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
