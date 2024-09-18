-- The file to define your languages, linters, debuggers, etc for automatic installation

local M = {}

-- Treesitter languages for automatic installation in lua/plugins/treesitter.lua
M.ts_languages = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "cuda",
  "dockerfile",
  "go",
  "gomod",
  "gowork",
  "gosum",
  "html",
  "java",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "nix",
  "proto",
  "python",
  "query",
  "regex",
  "rust",
  "rst",
  "svelte",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
  "zig",
}

-- NOTE: following tools rely on Mason installation. 
-- If you manage LSP, linters, and other tools yourself -- please consider 
-- setting g.mason_enabled = false in options.lua to avoid conflicts 

-- LSP Servers according to mason-lspconfig, used in lua/plugins/lspconfig.lua and lua/plugins/mason.lua
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/README.md#available-lsp-servers
M.lsp_servers = {
  "bashls",
  "bufls",
  -- Note for C/C++: for complex projects like Linux kernel, clang relies on "JSON compilation database"
  -- Use https://github.com/rizsotto/Bear to "wrap" build process and autogenerate compile_commands.json
  "clangd",
  "cssls",
  "dockerls",
  "emmet_ls",
  "html",
  "jsonls",
  "lua_ls",
  "neocmake",
  "pyright",
  "rust_analyzer",
  "svelte",
  "taplo",
  "ts_ls",
  "yamlls",
  "zls",
}

-- Debuggers for mason-nvim-dap.nvim
-- Available adapters: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
M.debug_tools = {
  "codelldb", -- c, c++, rust
  "delve", -- golang
  "python", -- technically, it's `debugpy`
  "js",
  -- "node2", -- javascriptreact, typescriptreact, typescript, javascript
  -- "chrome", -- same as node2
  -- "firefox", -- same as node2
}

M.null_ls = {
  "asmfmt",
  "black",
  "buf",
  -- "clang-format",
  "hadolint",
  -- "google_java_format",
  "isort",
  "prettier",
  "ruff",
  "shfmt",
  "stylua",
}

-- General Mason packages (no automatic installation: listed just for the reference)
-- https://github.com/mason-org/mason-registry/tree/main/packages
M.tools = {}

-- Note: take a look at `lua/plugins/null-ls.lua` below the `null_ls.setup {` line:
-- some tools like ruff (as a python diagnostics tool) are specified there

return M
