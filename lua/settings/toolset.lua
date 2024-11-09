-- The file to define your languages, linters, debuggers, etc for automatic installation

local M = {}

-- Treesitter languages for automatic installation
-- NOTE: if `auto_install = true` in ../plugins/treesitter.lua, grammars are installed
-- automatically on demand if `tree-sitter` CLI tool is available. Otherwise, you can manually
-- specify grammars in the list below -- they will be pre-installed even if you never use them.
M.ts_languages = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "cuda",
  "dockerfile",
  "editorconfig",
  "git_config",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "html",
  "java",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "luap",
  "make",
  "markdown",
  "markdown_inline",
  "nix",
  "printf",
  "proto",
  "python",
  "query",
  "regex",
  "rst",
  "rust",
  "scala",
  "sql",
  "ssh_config",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "udev",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

-- NOTE: following tools rely on Mason installation (except for lsp_with_no_mason)
-- If you manage LSP, linters, and other tools yourself, set g.mason_enabled = false in options.lua

-- LSP Servers according to nvim-lspconfig, used in lua/plugins/lspconfig.lua and lua/plugins/mason.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- Each LSP server specified here may have a custom configuration file in lua/settings/{lsp_server}.lua
-- which is loaded by lspconfig automatically. For example, if nixd.lua exists, it will be used to configure nixd
M.lsp_servers = {
  "basedpyright",
  "bashls", -- bash-language-server
  "buf_ls",  -- buf-language-server
  -- Note for C/C++: for complex projects like Linux kernel, clang relies on "JSON compilation database"
  -- Use https://github.com/rizsotto/Bear to "wrap" build process and autogenerate compile_commands.json
  "clangd",
  "cssls",
  "dockerls",
  "emmet_language_server",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "nil_ls",
  -- Edit settings/nixd.lua for better Nix autocompletion
  "nixd",
  "ruff",
  "rust_analyzer",
  "taplo",
  "terraformls",
  "ts_ls",
  "yamlls",
}
-- LSP servers that need external installation (not available via Mason)
-- If you add an entry to lsp_servers and see an error about ensure_installed,
-- you can add it to this list to exclude it from mason auto-installation
-- To look up servers in mason registry, see https://mason-registry.dev/registry/list
M.lsp_with_no_mason = {
  "nixd",
  "nil_ls",
}

-- Debuggers for mason-nvim-dap.nvim
-- Available adapters: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
M.debug_tools = {
  "codelldb", -- c, c++, rust
  "delve",    -- golang
  "python",   -- technically, it's `debugpy`
  "js",       -- js-debug-adapter
  -- "node2",   -- javascriptreact, typescriptreact, typescript, javascript
  -- "chrome",  -- same as node2
  -- "firefox", -- same as node2
}

-- null-ls/none-ls is a bridge between non-LSP language tools and the LSP ecosystem.
-- In ideal world, when each LSP server is perfect, there is no need for it.
-- This sources list is used in plugins/null_ls.lua and plugins/mason.lua
-- NOTE: Some built-in sources (like gitsigns) cause harmless Mason installation errors. You can exclude them in plugins/mason.lua
M.null_ls_sources = function(null_ls)
  return {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.gomodifytags,
    -- null_ls.builtins.completion.luasnip,
    -- null_ls.builtins.completion.spell,
    -- null_ls.builtins.completion.tags,
    -- null_ls.builtins.diagnostics.ansiblelint,
    -- null_ls.builtins.diagnostics.buf,
    -- null_ls.builtins.diagnostics.codespell,
    -- null_ls.builtins.diagnostics.hadolint,
    -- null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.staticcheck,
    -- null_ls.builtins.diagnostics.statix,
    -- null_ls.builtins.diagnostics.yamllint,
    -- null_ls.builtins.diagnostics.zsh,
    -- null_ls.builtins.formatting.alejandra,
    -- null_ls.builtins.formatting.black,
    -- null_ls.builtins.formatting.buf,
    -- null_ls.builtins.formatting.clang_format,
    -- null_ls.builtins.formatting.gofmt,
    -- null_ls.builtins.formatting.goimports,
    -- null_ls.builtins.formatting.google_java_format,
    -- null_ls.builtins.formatting.isort,
    -- null_ls.builtins.formatting.nixfmt,
    -- null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.hover.printenv,
  }
end

return M
