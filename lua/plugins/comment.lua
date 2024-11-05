-- Comment out lines, blocks, etc
-- Note: comment.nvim supports all treesitter languages except tsx/jsx out-of-the-box
-- https://github.com/numToStr/Comment.nvim

local M = {
  "numToStr/Comment.nvim",
  enabled = true,
  event = "BufRead",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  opts = function()
    return {
      -- Enable keybindings. If given `false` then the plugin won't create any mappings on its own
      mappings = {
        -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        -- Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
      -- Add a space b/w comment and the line
      padding = true,
      -- Whether the cursor should stay at its position
      sticky = true,
      -- Lines to be ignored while (un)comment
      ignore = nil,
      -- LHS of toggle mappings in NORMAL mode
      toggler = {
        line = "gcc", -- Line-comment toggle keymap
        block = "gbc", -- Block-comment toggle keymap
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        line = "gc", -- Line-comment keymap
        block = "gb", -- Block-comment keymap
      },
      ---LHS of extra mappings
      extra = {
        above = "gcO", -- Add comment on the line above
        below = "gco", -- Add comment on the line below
        eol = "gcA", -- Add comment at the end of line
      },
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,

  -- Fixing https://github.com/numToStr/Comment.nvim/issues/483
  -- Works in conjunction with adding `gc` and `gb` groups in which-key
  config = function(_, opts)
    require("Comment").setup(opts)
    vim.keymap.del("n", "gc")
    vim.keymap.del("n", "gb")
  end,
}

return M
