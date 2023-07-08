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

-- Buffer navigation
map("n", "<leader>n", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>q", "<cmd>Bdelete!<cr>", { desc = "Close buffer" })

local function goto_buf(i)
  return function()
    require("bufferline").go_to(i)
  end
end

for i = 1, 9 do
  map("n", "<leader>" .. i, goto_buf(i), { desc = "Go to buffer #" .. i })
end
map("n", "<leader>$", goto_buf(-1), { desc = "Go to the last buffer" })

-- Clear highlights
map("n", "<esc>", ":noh<cr>", { desc = "Clear highlights" })
map("n", "<leader>h", ":noh<cr>", { desc = "Clear highlights" })

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
map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "Search man pages" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Search NeoVim commands" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Search NeoVim help pages" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find <cr>", { desc = "Find in the current buffer" })
map("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Search through undo tree" })

-- Git
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Search through changed files (git status)" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Search through git branches" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Search through git commits" })
map("n", "<leader>gg", function() _LAZYGIT_TOGGLE() end, { desc = "Toggle LazyGit" })

-- comment
map("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle comment" })
map("x", "<leader>/",
  function() require("Comment.api").toggle.linewise(vim.fn.visualmode()) end,
  { desc = "Toggle comment" }
)

-- DAP
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
map("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<leader>dO", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle debug REPL" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run last" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })
map("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate DAP" })

-- Lsp
map("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, { desc = "Format code (LSP)" })

-- Aerial
map("n", "<leader>ss", "<cmd>AerialToggle!<cr>", { desc = "Toggle symbols explorer" })

-- Toggleterm
map("n", "<leader>ti", function() _IPY_TOGGLE() end, { desc = "Toggle iPython terminal" })
map("n", "<leader>tb", function() _BTOP_TOGGLE() end, { desc = "Toggle btop terminal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
map("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", { desc = "Toggle terminal tab" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
map("n", "<leader>tv", "<cmd>ToggleTerm size=50 direction=vertical<cr>", { desc = "Toggle vertical terminal" })
map("n", "<leader>t2h", "<cmd>2 ToggleTerm direction=horizontal<cr>", { desc = "Toggle 2nd horizontal terminal" })
map("n", "<leader>t2v", "<cmd>2 ToggleTerm size=50 direction=vertical<cr>", { desc = "Toggle 2nd vertical terminal" })

-- zen mode
map("n", "<leader>z", function()
  return require("zen-mode").toggle()
end, { desc = "Toggle Zen mode" })

-- Mini.Sessions (note: there is no need for manual saving because of MiniSession.config.autosave = true)
map("n", "<leader>sr",
  function() require("mini.sessions").read(nil) end,
  { desc = "Load local or latest global session" }
)
map("n", "<leader>sR", function() require("mini.sessions').select('read") end, { desc = "Select & load a session" })
map("n", "<leader>sw",
  function()
    local M = require("mini.sessions"); M.write(M.config.file)
  end,
  { desc = "Write a local session" }
)
map("n", "<leader>sW", function() require("mini.sessions').select('write") end, { desc = "Select & write a session" })
map("n", "<leader>sd", function() require("mini.sessions").delete(nil) end, { desc = "Delete current session" })
map("n", "<leader>sD", function() require("mini.sessions').select('delete") end, { desc = "Select & delete a session" })

-- smart-splits
-- resizing splits
map("n", "<M-h>", function() require("smart-splits").resize_left() end, { desc = "Grow split left" })
map("n", "<M-j>", function() require("smart-splits").resize_down() end, { desc = "Grow split down" })
map("n", "<M-k>", function() require("smart-splits").resize_up() end, { desc = "Grow split up" })
map("n", "<M-l>", function() require("smart-splits").resize_right() end, { desc = "Grow split right" })
-- moving between splits
map("n", "<C-h>", function() require("smart-splits").move_cursor_left() end, { desc = "Move to the left split" })
map("n", "<C-j>", function() require("smart-splits").move_cursor_down() end, { desc = "Move to the split below" })
map("n", "<C-k>", function() require("smart-splits").move_cursor_up() end, { desc = "Move to the split above" })
map("n", "<C-l>", function() require("smart-splits").move_cursor_right() end, { desc = "Move to the right split" })
-- swapping buffers between windows
map("n", "<leader><leader>h",
  function() require("smart-splits").swap_buf_left() end,
  { desc = "Swap with the left buffer" }
)
map("n", "<leader><leader>j",
  function() require("smart-splits").swap_buf_down() end,
  { desc = "Swap with the buffer below" }
)
map("n", "<leader><leader>k",
  function() require("smart-splits").swap_buf_up() end,
  { desc = "Swap with the buffer above" }
)
map("n", "<leader><leader>l",
  function() require("smart-splits").swap_buf_right() end,
  { desc = "Swap with the right buffer" }
)
