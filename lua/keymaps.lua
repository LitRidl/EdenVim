local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("keep", opts or {}, {
    silent = true,
  })
  vim.keymap.set(mode, lhs, rhs, opts)
end

--Remap space as leader key
map("", "<Space>", "<Nop>", { desc = "Leader key" })
vim.g.mapleader = " "
-- local f;
-- if 
-- if 
--
-- f = 5
--
-- f = "df"
--
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
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Clear highlights
map("n", "<Esc>", ":noh<cr>", { desc = "Clear highlights" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })

-- Close buffers
map("n", "<S-q>", "<cmd>Bdelete!<cr>", { desc = "Close buffer" })

-- Pasting over the selected text in Visual mode
map("v", "p", "P", { desc = "Paste over the selected text" })

-- Insert --


-- Visual --
-- Stay in indent mode (by default, < and > in V result in switch to the N mode)
map("v", "<", "<gv", { desc = "Decrease indent and reselect the text" })
map("v", ">", ">gv", { desc = "Increase indent and reselect the text" })

-- Save file with Ctrl + s
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })


-- Navigation in Insert mode
map("i", "<C-h>", "<Left>", { desc = "Move cursor left" })
map("i", "<C-j>", "<Down>", { desc = "Move cursor down" })
map("i", "<C-k>", "<Up>", { desc = "Move cursor up" })
map("i", "<C-l>", "<Right>", { desc = "Move cursor right" })

-- Plugins --

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree file browser"})

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" })
map("n", "<leader>ft", "<cmd>Telescope live_grep<cr>", { desc = "Telescope live grep" })
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Telescope search projects" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope search buffers" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>", { desc = "Telescope find files (all)" }) -- Find all
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find <cr>", { desc = "Telescope find in the current buffer" }) -- find in current buffer
map("n", "<leader>fsr", "<cmd>Telescope file_browser<cr>", { desc = "Telescope file browser (in root folder)" })
map("n", "<leader>fsc", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "Telescope file browser (wrt to open file)" })

-- Git
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", { desc = "Toggle LazyGit" })

-- comment
map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", { desc = "Toggle comment" })
map("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { desc = "Toggle comment" })

-- DAP
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "Continue" })
map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Step Into" })
map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Step Over" })
map("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", { desc = "Step Out" })
map("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "Toggle debug REPL" })
map("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { desc = "Run last" })
map("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "Toggle DAP UI" })
map("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", { desc = "Terminate DAP" })

-- Lsp
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { desc = "Format code (LSP)" })

-- Aerial
map("n", "<leader>ss", "<cmd>AerialToggle!<cr>", { desc = "Toggle symbols explorer" })

-- Toggleterm
map("n", "<leader>py", "<cmd>lua _PY_TOGGLE()<cr>", { desc = "Toggle iPython terminal" })

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
map("n", "<leader><leader>h", "<cmd>lua require('smart-splits').swap_buf_left()<cr>", { desc = "Swap with the left buffer" })
map("n", "<leader><leader>j", "<cmd>lua require('smart-splits').swap_buf_down()<cr>", { desc = "Swap with the buffer below" })
map("n", "<leader><leader>k", "<cmd>lua require('smart-splits').swap_buf_up()<cr>", { desc = "Swap with the buffer above" })
map("n", "<leader><leader>l", "<cmd>lua require('smart-splits').swap_buf_right()<cr>", { desc = "Swap with the right buffer" })

