-- Split pane management that uses a model of left/right/up/down instead of wider/narrower/taller/shorter for resizing
-- Supports navigation between Neovim and terminal multiplexer split panes.
-- Note: for Tmux or other multiplexers to support this, refer integration section of the url below
-- https://github.com/mrjones2014/smart-splits.nvim

local M = {
  "mrjones2014/smart-splits.nvim",
  enabled = true,
  lazy = false,
  -- to use Kitty multiplexer support, run the post install hook
  -- build = './kitty/install-kittens.bash',
}

return M
