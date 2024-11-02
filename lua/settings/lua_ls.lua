local opts = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      codeLens = {
        enable = true,
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          -- Path of this config's lua directory
          [vim.fn.stdpath "config" .. "/lua"] = true,
          require("neodev.config").types(),
          -- Fixing annoying neodev prompt about luv when editing standalone lua files
          -- That's an issue in LunarVim: https://github.com/LunarVim/LunarVim/issues/4049
          "${3rd}/luv/library",
        },
        -- Slightly less correct way to fix the issue mentioned above. Uncomment if can't configure above
        -- checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

return opts
