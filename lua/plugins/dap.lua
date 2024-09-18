-- Debug Adapter Protocol client implementation (attach to process, launch app to debug, set breakpoint, etc)
-- Note: it is so tied with its dependencies that all of them are defined here, in a single file
-- Stack-specific references: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- https://github.com/mfussenegger/nvim-dap/

-- Terminology is confusing here, so here is a recap:
  -- DAP-Client ----- Debug Adapter ------- Debugger ------ Debugee
  -- (nvim-dap)  |   (per language)  |   (per language)    (your app)
  --             |                   |
  --             |        Implementation specific communication
  --             |        Debug adapter and debugger could be the same process
  --             |
  --      Communication via the Debug Adapter Protocol

local M = {
  "mfussenegger/nvim-dap",
  enabled = true,
  event = "VeryLazy",

  dependencies = {
    "nvim-neotest/nvim-nio",

    -- An IDE-like UI for DAP (inspired by LunarVim/nvim-basic-ide)
    -- https://github.com/rcarriga/nvim-dap-ui
    {
      "rcarriga/nvim-dap-ui",
      enabled = true,
      opts = {
        expand_lines = true,
        icons = { expanded = "", collapsed = "", circular = "" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.33 },
              { id = "breakpoints", size = 0.17 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 0.33,
            position = "right",
          },
          {
            elements = {
              { id = "repl", size = 0.45 },
              { id = "console", size = 0.55 },
            },
            size = 0.27,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.5, -- Floats will be treated as percentage of your screen.
          border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
      },
      config = function(_, opts)
        local dap = require "dap"
        local dapui = require "dapui"
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open {}
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close {}
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close {}
        end
      end,
    },

    -- Displaying values of variables during debugging, highlighting changed variables, etc
    -- https://github.com/theHamsta/nvim-dap-virtual-text
    {
      "theHamsta/nvim-dap-virtual-text",
      enabled = true,
      opts = {},
    },

    -- A bridge between mason and dap that allows automatic installation and configuring of debuggers and their adapters
    -- Note: it automatically creates basic default launch configurations for each debugging adapter.
    -- Eventually, it is likely that if you need advanced debugging, you'll have to create configurations on
    -- your own. Mason-nvim-dap provides just this: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/configurations.lua
    -- If you need to create adapter configurations, see https://harrisoncramer.me/debugging-in-neovim/
    -- For support of VS Code launch.json debug configurations, see `:h dap-launch.json`
    -- https://github.com/jay-babu/mason-nvim-dap.nvim
    {
      "jay-babu/mason-nvim-dap.nvim",
      enabled = vim.g.mason_enabled,
      dependencies = "williamboman/mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        ensure_installed = require("settings.toolset").debug_tools,

        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},
      },
    },
  },
  -- End of dependencies, back to the dap itself

  opts = {},

  config = function(_, opts)
    -- Set highlighting of a debugger-active line to the style of Visual mode highlighting
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticSignError" })

    -- You can create your own configurations and adapters in a separate modules and require() them here
    -- or just put the code here like this (codelldb and c are just examples):
    -- For support of VS Code launch.json debug configurations, see `:h dap-launch.json`
    -- 
    -- local dap = require("dap")
    --
    -- dap.adapters.codelldb = {
    --   type = "server",
    --   port = "${port}",
    --   -- etc ...
    -- }
    --
    -- dap.configurations.c = {
    --   
    --     name = "C Debug And Run",
    --     type = "codelldb",
    --     request = "launch",
    --     -- etc ...
    --   },
    --   {
    --     -- another C configuration...
    --   },
    -- }
  end,
}

return M
