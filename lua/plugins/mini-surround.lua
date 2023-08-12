-- Add, delete, replace, find, highlight surrounding (like pair of parenthesis, quotes, etc)
-- https://github.com/echasnovski/mini.surround

local M = {
  "echasnovski/mini.surround",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- These are the default mappings, but they come with a catch: lua/plugins/flash-nvim.lua
    -- uses 's' to enter jump mode. If you delay a bit after pressing 's', you will end in
    -- a flash-nvim jump mode. To overcome this, type 'sa', 'sd' and other keybinds quickly.
    -- If you're fine with this, uncomment this block and comment alternative block
    -- mappings = {
    --   add = "sa",            -- Add surrounding in Normal and Visual modes
    --   delete = "sd",         -- Delete surrounding
    --   find = "sf",           -- Find surrounding (to the right)
    --   find_left = "sF",      -- Find surrounding (to the left)
    --   highlight = "sh",      -- Highlight surrounding
    --   replace = "sr",        -- Replace surrounding
    --   update_n_lines = "sn", -- Update `n_lines`
    --
    --   suffix_last = "l",     -- Suffix to search with "prev" method
    --   suffix_next = "n",     -- Suffix to search with "next" method
    -- },
    -- Alternative LazyVim keybinds that don't conflict with flash-nvim when typing slow
    -- Also, it enabled which-key to react properly
    mappings = {
      add = "gza",            -- Add surrounding in Normal and Visual modes
      delete = "gzd",         -- Delete surrounding
      find = "gzf",           -- Find surrounding (to the right)
      find_left = "gzF",      -- Find surrounding (to the left)
      highlight = "gzh",      -- Highlight surrounding
      replace = "gzr",        -- Replace surrounding
      update_n_lines = "gzn", -- Update `n_lines`

      suffix_last = "l", -- Suffix to search with "prev" method
      suffix_next = "n", -- Suffix to search with "next" method
    },
  },
}

function M.config(_, opts)
  require("mini.surround").setup(opts)
end

return M
