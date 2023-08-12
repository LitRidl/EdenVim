-- Rust inlay hints, runnabled for debugging, macros expansion, hover actions, etc
-- Note: it automatically sets up rust_analyzer in nvim-lspconfig, don't do it manually
-- https://github.com/simrat39/rust-tools.nvim

local M = {
  "simrat39/rust-tools.nvim",
  enabled = true,
  ft = { "rust" },
  dependencies = { "jay-babu/mason-nvim-dap.nvim", "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
}

function M.opts()
  local adapter
  local success, package = pcall(function()
    return require("mason-registry").get_package "codelldb"
  end)

  if success then
    local package_path = package:get_install_path()
    local codelldb_path = package_path .. "/codelldb"
    local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
    local this_os = vim.loop.os_uname().sysname

    -- The path in windows is different
    if this_os:find "Windows" then
      codelldb_path = package_path .. "\\extension\\adapter\\codelldb.exe"
      liblldb_path = package_path .. "\\extension\\lldb\\bin\\liblldb.dll"
    else
      -- The liblldb extension is .so for linux and .dylib for macOS
      liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
    end
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
  else
    adapter = require("rust-tools.dap").get_codelldb_adapter()
  end

  return {
    server = require("lspconfig").rust_analyzer,
    dap = { adapter = adapter },
  }
end

return M
