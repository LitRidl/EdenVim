-- Displays a popup with possible key bindings of the command you started typing
-- https://github.com/folke/which-key.nvim

local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- which-key popup window style = "classic" | "modern" | "helix"
    -- classic is without borders, modern has them, and helix is aligned to the right
    preset = "modern",
    defaults = {},
    -- All keymaps, no matter how defined, are scanned for the following prefixes (groups)
    -- and if they match, they are considered to be a part of a group in the popup
    spec = {
      {
        mode = { "n", "v" },
        -- Good choice for your personal set of frequently used keybinds
        -- It you add keybinds under leader leader in keymaps.lua, they will be automatically grouped here
        { "<leader><leader>", group = "frequent" },
        { "<leader>d",        group = "debug" },
        { "<leader>f",        group = "find & files" },
        { "<leader>r",        group = "replace text" },
        { "<leader>g",        group = "git" },
        { "<leader>h",        group = "help, config info" },
        { "<leader>gh",       group = "git hunks navigation" },
        { "<leader>l",        group = "lsp (code actions)" },
        { "<leader>s",        group = "session" },
        { "<leader>b",        group = "buffers" },
        { "<leader>t",        group = "terminal" },
        -- Second terminal is opinionated, if you want it -- uncomment keybinds for it in keymaps.lua
        { "<leader>t2",       group = "second terminal" },
        { "<leader>o",        group = "options, ui" },
        { "<leader>x",        group = "diagnostics/trouble" },
        { "<leader><tab>",    group = "tabpages" },
        { "[",                group = "prev" },
        { "]",                group = "next" },
        { "g",                group = "goto, surround, comment" },
        { "gb",               group = "comment toggle blockwise" },
        { "gc",               group = "comment toggle linewise" },
        { "gz",               group = "surround" },
        { "z",                group = "folds, centering, spelling" },
      },
    },
    icons = {
      -- separator = "󱦰", -- symbol used between a key and it's label
      -- breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      -- group = "+", -- symbol prepended to a group
      rules = {
        { pattern = "lsp", icon = " ", color = "cyan" },
        { pattern = "save", icon = " ", color = "cyan" },
        { pattern = "undo", icon = "󰕌 ", color = "cyan" },
        { pattern = "zen", icon = "󱅻 ", color = "cyan" },
        { pattern = "close", icon = "󰅘 ", color = "cyan" },
        { pattern = "help", icon = "󰋗 ", color = "cyan" },
        { pattern = "replace", icon = "󰛔 ", color = "cyan" },
        { pattern = "file browser", icon = "󰙅 ", color = "cyan" },
      },
    },
    win = {
      -- If it's difficult to distinguish which-key popup from the background
      -- and preset = "modern" is too narrow for you, set it to "classic" and uncomment this
      -- border = "single",
    },
  },
}

function M.config(_, opts)
  -- `which-key` may report an annoying info message for some plygins using operator-pending mode.
  -- It is safe to ignore this message: according to `which-key`, `Overlapping keymaps are only reported for informational purposes`.
  -- If you want to see the message, you can comment out the following block:
  local original_notify = vim.notify
  vim.notify = function(msg, ...)
    if not msg:match("checking for overlapping keymaps") then
      original_notify(msg, ...)
    end
  end

  local wk = require "which-key"
  wk.setup(opts)
  wk.add(opts.defaults)
end

return M
