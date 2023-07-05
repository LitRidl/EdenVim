local M = {
  "nvim-telescope/telescope.nvim",
  -- commit = "40c31fdde93bcd85aeb3447bb3e2a3208395a868",
  event = "Bufenter",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },
}

M.opts = {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    mappings = {
      i = {
        ["<Down>"] = function(...)
          return require("telescope.actions").move_selection_next(...)
        end,
        ["<Up>"] = function(...)
          return require("telescope.actions").move_selection_previous(...)
        end,
        ["<C-j>"] = function(...)
          return require("telescope.actions").move_selection_next(...)
        end,
        ["<C-k>"] = function(...)
          return require("telescope.actions").move_selection_previous(...)
        end,
      },
      n = {
        ["q"] = function(...)
          return require("telescope.actions").close(...)
        end,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
}

return M
