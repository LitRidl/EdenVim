-- Copilot support
-- Note: Copilot is disabled by default, but if you have an API token -- feel free to enable it
-- If you prefer Copilot suggestions in a form of cmp autocompletions, add https://github.com/zbirenbaum/copilot-cmp
-- https://github.com/zbirenbaum/copilot.lua

local M = {
  "zbirenbaum/copilot.lua",
  enabled = false,
  build = ":Copilot auth",

  cmd = "Copilot",
  event = "InsertEnter", -- Delete if don't want to load the plugin w/o implicit invocation of :Copilot

  -- The default plugin configuration
  opts = {
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>",
      },
      layout = {
        position = "bottom", -- | top | left | right
        ratio = 0.4,
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = false,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
  },
}

return M
