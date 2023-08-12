-- Move any selection in any direction (smart: reindents vertical movements, respects v:count, etc)
-- https://github.com/echasnovski/mini.move

-- Shift + Alt/Meta + Direction
local keymap = {
  left = "<M-H>",
  right = "<M-L>",
  down = "<M-J>",
  up = "<M-K>",
}

local M = {
  "echasnovski/mini.move",
  enabled = true,
  keys = {
    { keymap.left,  mode = { "n", "x" } },
    { keymap.right, mode = { "n", "x" } },
    { keymap.down,  mode = { "n", "x" } },
    { keymap.up,    mode = { "n", "x" } },
  },
  opts = {
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = keymap.left,
      right = keymap.right,
      down = keymap.down,
      up = keymap.up,

      -- Move current line in Normal mode
      line_left = keymap.left,
      line_right = keymap.right,
      line_down = keymap.down,
      line_up = keymap.up,
    },

    -- Options which control moving behavior
    options = {
      -- Automatically reindent selection during linewise vertical move
      reindent_linewise = true,
    },
  },
  config = function(_, opts)
    require("mini.move").setup(opts)
  end,
}

return M
