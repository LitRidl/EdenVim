-- The file to define your languages, linters, debuggers, etc for automatic installation
-- To understand internals, please read "Core Tools and Language Support" under "Customization" in README.md

local M = {}

-- Treesitter languages for automatic installation
-- NOTE: if `auto_install = true` in `lua/plugins/treesitter.lua`, grammars are installed
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
  "zig",
}

-- LSP Servers according to nvim-lspconfig. `lua/plugins/lspconfig.lua` configures LSP servers with defaults which you can extend:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- Each LSP server specified here may have a custom configuration in `lua/settings/{server}.lua` which will automatically loaded.
-- For example, if `lua/settings/nixd.lua` exists, options in it will be merged with nvim-lspconfig defaults and used to configure nixd.
-- It's NOT Mason installation list: only a list of LSP servers to be configured and set up with nvim-lspconfig.
M.lsp_servers = {
  "basedpyright",
  "bashls", -- bash-language-server
  "buf_ls",  -- buf
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
  "zls",
}

-- Following sections describe tools that should be installed with Mason
-- If you manage LSP, linters, and other tools yourself, set `g.mason_enabled = false` in `lua/options.lua`

-- LSP servers marked for external installation (not available via Mason or you want to use your own installation):
-- If you add an entry to `lsp_servers` and see an error about `ensure_installed`,
-- you can add it to this list to exclude it from mason auto-installation
-- To look up servers in mason registry, see https://mason-registry.dev/registry/list
M.lsp_with_no_mason = {
  "nixd",
  "nil_ls",
}

-- You can conditionally exclude a server from auto-installation
-- Example: exclude clangd if `clangd` executable is already available in your environment
if vim.fn.executable("clangd") == 1 then
    table.insert(M.lsp_with_no_mason, "clangd")
end
if vim.fn.executable("gopls") == 1 then
    table.insert(M.lsp_with_no_mason, "gopls")
end

-- List of LSP servers to be installed with Mason
-- This table is used by `lua/plugins/mason.lua` and during Docker build (to bootstrap dependencies)
-- It takes `lsp_servers` from above and exclude `lsp_with_no_mason` from it
M.lsp_mason_install = vim.tbl_filter(
  function(server)
    return not vim.tbl_contains(M.lsp_with_no_mason, server)
  end,
  M.lsp_servers
)

-- Debug adapters for mason-nvim-dap.nvim (see `lua/plugins/dap.lua` for explanation)
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
-- This sources list is used in `lua/plugins/null_ls.lua` and `lua/plugins/mason.lua`
-- NOTE: Some built-in sources (like gitsigns) cause harmless Mason installation errors. You can exclude them in `lua/plugins/mason.lua`
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
