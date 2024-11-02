-- The file to define your languages, linters, debuggers, etc for automatic installation

local M = {}

-- Treesitter languages for automatic installation by ../plugins/treesitter.lua
-- NOTE: if `auto_install = true` in ../plugins/treesitter.lua, grammars are installed
-- automatically and don't have to be specified here. For this to work, ensure that you
-- have `tree-sitter` CLI tool available. Otherwise, you can manually specify grammars
-- in the list below: they are guaranteed to be installed even if you never used them.
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

-- NOTE: following tools rely on Mason installation. 
-- If you manage LSP, linters, and other tools yourself -- please consider 
-- setting g.mason_enabled = false in options.lua to avoid conflicts 

-- LSP Servers according to mason-lspconfig, used in lua/plugins/lspconfig.lua and lua/plugins/mason.lua
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/README.md#available-lsp-servers
M.lsp_servers = {
  "bashls", -- bash-language-server
  "bufls",  -- buf-language-server
  -- Note for C/C++: for complex projects like Linux kernel, clang relies on "JSON compilation database"
  -- Use https://github.com/rizsotto/Bear to "wrap" build process and autogenerate compile_commands.json
  "clangd",
  "gopls",
  "cssls",
  "dockerls",
  "terraformls",
  "emmet_language_server",
  "html",
  "jsonls",
  "lua_ls",
  "basedpyright",
  "ruff",
  "nixd",
  "rust_analyzer",
  "taplo",
  "ts_ls",
  "yamlls",
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

-- null-ls is a bridge between non-LSP language tools and the LSP ecosystem.
-- In ideal world, when each LSP server is perfect, there is no need for it.
-- This list is used in plugins/null_ls and plugins/mason
M.null_ls_sources = function (null_ls)
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

-- General Mason packages (no automatic installation: listed just for the reference)
-- https://github.com/mason-org/mason-registry/tree/main/packages
M.tools = {}

-- Note: take a look at `lua/plugins/null-ls.lua` below the `null_ls.setup {` line:
-- some tools like ruff (as a python diagnostics tool) are specified there

return M
