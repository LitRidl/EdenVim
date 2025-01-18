-- Highly extendable fuzzy finder over lists (+ builtin features like search among files, keymaps, etc)
-- https://github.com/nvim-telescope/telescope.nvim

local M = {
  "nvim-telescope/telescope.nvim",
  enabled = true,
  cmd = { "Telescope" },
  dependencies = {
    {
      -- A "default" dependency -- for example, has lots of pre-made path handling functions
      -- https://github.com/nvim-lua/plenary.nvim
      'nvim-lua/plenary.nvim',
    },
    {
      -- FZF sorter for telescope written in c
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    {
      -- Visualize your undo tree and fuzzy-search changes in it
      -- <cr> to yank additions, s-<cr> to yank deletions, c+<cr> to restore
      -- https://github.com/debugloop/telescope-undo.nvim
      "debugloop/telescope-undo.nvim",
    },
  },
}

M.opts = {
  defaults = {
    prompt_prefix = " ",
    selection_caret = "󰐊 ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", ".direnv/", "node_modules/", "__pycache__/", ".cache/" },
    color_devicons = true,
    -- A hack sometimes required when telescope uses `bat` for preview
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
      find_command = { "rg", "--color=never", "--ignore-case", "--files", "-g", "!**/.git/*" },
      -- `hidden = true` makes Telescope show hidden files, except ignored ones
      hidden = false,
      follow = true,
      -- show files ignored by .gitignore, .ignore, etc.
      no_ignore = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
    },
    undo = {
      layout_strategy = "horizontal",
      layout_config = {
        preview_width = 0.5,
      },
    },
  },
}

function M.config(_, opts)
  -- if ripgrep is not available, fall back to find
  if vim.fn.executable("rg") ~= 1 then
    opts.pickers.find_files.find_command = { "find", ".", "-type", "f" }
  end
  require("telescope").setup(opts)

  require("telescope").load_extension "undo"
  require("telescope").load_extension "fzf"
end

return M
