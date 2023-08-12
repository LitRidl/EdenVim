-- Automatic closing of (, [, ', ", { and FastWrap mode (see below)
-- Note: it is integrated with nvim-cmp
-- https://github.com/windwp/nvim-autopairs

local M = {
  "windwp/nvim-autopairs",
  enabled = true,
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },
  opts = {
    check_ts = true, -- treesitter integration
    disable_filetype = { "TelescopePrompt" },
    -- Don't add pairs if it already has a close pair in the same line
    enable_check_bracket_line = false,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },

    -- Before        Input                    After
    -- --------------------------------------------------
    -- (|foobar      <M-e> then press $        (|foobar)
    -- (|)(foobar)   <M-e> then press q       (|(foobar))
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0, -- Offset from pattern match
      end_key = "$",
      -- in <M-e> mode autopairs suggests locations for the closing bracket and marks them with these keys
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
    },
  },
}

function M.config(_, opts)
  require("nvim-autopairs").setup(opts)
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  local cmp = require "cmp"

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
end

return M
