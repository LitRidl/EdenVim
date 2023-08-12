-- Autocommands allow execution of arbitrary code upon specified conditions like
-- For autocmd description, see `desc` field
-- events: https://neovim.io/doc/plugins/autocmd.html#events (FileType is an event, too)

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Create missing directories when saving a file if they don't exist",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Maps `q` to exit service buffers and excludes them from buffer listings",
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "checkhealth", "neotest-summary", "neotest-output", "neotest-output-panel" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>Bdelete<cr>", { desc = "Close buffer", silent = true, noremap = true })
    vim.bo.buflisted = false
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Enable line wrapping and spell correction in markdown files and gitcommit",
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "On resize, execute wincmd= (make all windows equal in size) for each tab",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Highlight yanked (= copied) so that the user is more confident in what was yanked",
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- If a session is saved while nvim-tree is open, its buffer will be empty upon session restoration
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  desc = "Fix empty nvim-tree buffer by checking if it is visible during session restoration and refreshing it",
  pattern = "NvimTree*",
  callback = function()
    local api = require "nvim-tree.api"
    local view = require "nvim-tree.view"

    if not view.is_visible() then
      api.tree.open()
    end
  end,
})

-- You may put your autocommands here

-- Example of useful autocommand
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   desc = "Auto-format *.rs (rust) files prior to saving them",
--   pattern = { "*.rs" },
--   callback = function()
--     vim.lsp.buf.format { async = false }
--   end,
-- })

-- Example of useful autocommand
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   desc = "refreshing codelens (file-specific LSP actions) for java",
--   pattern = { "*.java" },
--   callback = function()
--     vim.lsp.codelens.refresh()
--   end,
-- })
