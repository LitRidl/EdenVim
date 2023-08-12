-- Parsing library. It can build a syntax tree for a source file and efficiently update it as the source file is edited
-- Note: try ctrl + space keybind for incremental selection, it's very nice
-- https://github.com/nvim-treesitter/nvim-treesitter

local M = {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- for ensure_installed, see config() below

    ignore_install = { "" }, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true, -- false will disable the whole extension
      -- disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    indent = {
      enable = true,
      -- disable = { "python", "css" }
    },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
}

function M.config(_, opts)
  opts.ensure_installed = require("settings.toolset").ts_languages
  require("nvim-treesitter.configs").setup(opts)
end

return M
