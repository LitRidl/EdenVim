-- Comment out lines, blocks, etc
-- Note: comment.nvim supports all treesitter languages except tsx/jsx out-of-the-box
-- https://github.com/numToStr/Comment.nvim

local M = {
  "numToStr/Comment.nvim",
  enabled = true,
  event = "BufRead",
  -- Tsx/jsx support: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  opts = {
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
    pre_hook = nil,
  },
}

function M.config(_, opts)
  opts.pre_hook = function(ctx)
    -- Only calculate commentstring for tsx filetypes
    if vim.bo.filetype == "typescriptreact" then
      local U = require "Comment.utils"

      -- Determine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

      -- Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.blockwise then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end

      return require("ts_context_commentstring.internal").calculate_commentstring {
        key = type,
        location = location,
      }
    end
  end

  require("Comment").setup(opts)
end

return M
