local M = {
  "j-hui/fidget.nvim",
  enabled = true,
  -- As per github: fidget.nvim will soon be completely rewritten. In the meantime, these instructions will pin
  -- your configuration to the legacy branch to avoid breaking changes.
  tag = "legacy",
  event = "LspAttach",
  opts = {
    window = { blend = 0 },
  },
}

return M
