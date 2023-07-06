local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("keep", opts or {}, {
    silent = true,
  })
  vim.keymap.set(mode, lhs, rhs, opts)
end

--Remap space as leader key
map("", "<Space>", "<Nop>", { desc = "Leader key" })
vim.g.mapleader = " "

-- f = {}
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- map("n", "<C-h>", "<C-w>h", { desc = "Move to the left window" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Move to the window above" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Move to the right window" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Move to the window below" })

-- Resize with arrows
-- map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Increase window height" })
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Decrease window height" })
-- map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase window width" })
-- map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease window width" })

-- Navigate buffers
map("n", "<leader>n", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Clear highlights
map("n", "<esc>", ":noh<cr>", { desc = "Clear highlights" })
map("n", "<leader>h", ":noh<cr>", { desc = "Clear highlights" })

-- Close buffers
map("n", "<leader>q", "<cmd>Bdelete!<cr>", { desc = "Close buffer" })

-- Putting new lines without leaving Normal mode
map("n", "<leader>o", "mpo<esc>`p")
map("n", "<leader>O", "mpO<esc>`p")

map("n", "<leader>sr", function()
  require("spectre").open()
end, { desc = "Replace in files (Spectre)" })
-- Save file with Ctrl + s
map({ "n", "i" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Insert --

-- Visual --
-- Stay in indent mode (by default, < and > in V result in switch to the N mode)
map("v", "<", "<gv", { desc = "Decrease indent and reselect the text" })
map("v", ">", ">gv", { desc = "Increase indent and reselect the text" })

map("v", "<leader>p", '"_dP', { desc = "Paste over that doesn't change next paste" })
map("v", "p", "P", { desc = "Paste over the selected text" })

-- Navigation in Insert mode
map("i", "<C-h>", "<Left>", { desc = "Move cursor left" })
map("i", "<C-j>", "<Down>", { desc = "Move cursor down" })
map("i", "<C-k>", "<Up>", { desc = "Move cursor up" })
map("i", "<C-l>", "<Right>", { desc = "Move cursor right" })

-- Plugins --

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree file browser" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files by path" })
map("n", "<leader>ft", "<cmd>Telescope live_grep<cr>", { desc = "Search through files (live grep)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Search buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Search recently opened files" })
map("n", "<leader>fR", "<cmd>Telescope registers<cr>", { desc = "Search registers" })
map("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Search through undo tree" })
map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "Search man pages" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Search NeoVim help pages" })
map(
  "n",
  "<leader>fz",
  "<cmd>Telescope current_buffer_fuzzy_find <cr>",
  { desc = "Telescope find in the current buffer" }
)

-- Git
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Search through changed files (git status)" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Search through git branches" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Search through git commits" })
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", { desc = "Toggle LazyGit" })

-- comment
map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", { desc = "Toggle comment" })
map(
  "x",
  "<leader>/",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
  { desc = "Toggle comment" }
)

-- DAP
map("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
map("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", { desc = "Continue" })
map("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>", { desc = "Step Into" })
map("n", "<leader>do", "<cmd>lua require('dap').step_over()<cr>", { desc = "Step Over" })
map("n", "<leader>dO", "<cmd>lua require('dap').step_out()<cr>", { desc = "Step Out" })
map("n", "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", { desc = "Toggle debug REPL" })
map("n", "<leader>dl", "<cmd>lua require('dap').run_last()<cr>", { desc = "Run last" })
map("n", "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", { desc = "Toggle DAP UI" })
map("n", "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", { desc = "Terminate DAP" })

-- Lsp
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { desc = "Format code (LSP)" })

-- Aerial
map("n", "<leader>ss", "<cmd>AerialToggle!<cr>", { desc = "Toggle symbols explorer" })

-- Toggleterm
map("n", "<leader>ipy", "<cmd>lua _PY_TOGGLE()<cr>", { desc = "Toggle iPython terminal" })

-- Mini.Sessions (note: there is no need for manual saving because of MiniSession.config.autosave = true)
map(
  "n",
  "<leader>sr",
  "<cmd>lua require('mini.sessions').read(nil)<cr>",
  { desc = "Load local or latest global session" }
)
map("n", "<leader>sR", "<cmd>lua require('mini.sessions').select('read')<cr>", { desc = "Select & load a session" })
map(
  "n",
  "<leader>sw",
  "<cmd>local M = require('mini.sessions'); M.write(M.config.file)<cr>",
  { desc = "Write a local session" }
)
map("n", "<leader>sW", "<cmd>lua require('mini.sessions').select('write')<cr>", { desc = "Select & write a session" })
map("n", "<leader>sd", "<cmd>lua require('mini.sessions').delete(nil)<cr>", { desc = "Delete current session" })
map("n", "<leader>sD", "<cmd>lua require('mini.sessions').select('delete')<cr>", { desc = "Select & delete a session" })

-- smart-splits
-- resizing splits
map("n", "<M-h>", "<cmd>lua require('smart-splits').resize_left()<cr>", { desc = "Grow split left" })
map("n", "<M-j>", "<cmd>lua require('smart-splits').resize_down()<cr>", { desc = "Grow split down" })
map("n", "<M-k>", "<cmd>lua require('smart-splits').resize_up()<cr>", { desc = "Grow split up" })
map("n", "<M-l>", "<cmd>lua require('smart-splits').resize_right()<cr>", { desc = "Grow split right" })
-- moving between splits
map("n", "<C-h>", "<cmd>lua require('smart-splits').move_cursor_left()<cr>", { desc = "Move to the left split" })
map("n", "<C-j>", "<cmd>lua require('smart-splits').move_cursor_down()<cr>", { desc = "Move to the split below" })
map("n", "<C-k>", "<cmd>lua require('smart-splits').move_cursor_up()<cr>", { desc = "Move to the split above" })
map("n", "<C-l>", "<cmd>lua require('smart-splits').move_cursor_right()<cr>", { desc = "Move to the right split" })
-- swapping buffers between windows
map(
  "n",
  "<leader><leader>h",
  "<cmd>lua require('smart-splits').swap_buf_left()<cr>",
  { desc = "Swap with the left buffer" }
)
map(
  "n",
  "<leader><leader>j",
  "<cmd>lua require('smart-splits').swap_buf_down()<cr>",
  { desc = "Swap with the buffer below" }
)
map(
  "n",
  "<leader><leader>k",
  "<cmd>lua require('smart-splits').swap_buf_up()<cr>",
  { desc = "Swap with the buffer above" }
)
map(
  "n",
  "<leader><leader>l",
  "<cmd>lua require('smart-splits').swap_buf_right()<cr>",
  { desc = "Swap with the right buffer" }
)
