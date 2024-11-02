-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "x",
--   select_mode = "s",
--   visual_and_select = "v",
--   term_mode = "t",
--   command_mode = "c",
--   operator_pending = "o",
--
--   Note: visual `x`, select `s`, and visual_and_select (`v` = `s` + `x`) modes are different: prefer "x" for visual
--   Please see `:h Select-mode-mapping` for details

-- Helper for a vim.keymap.set()
local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("keep", opts or {}, {
    silent = true,
  })
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Remap space as leader key
map("", "<Space>", "<Nop>", { desc = "Leader key" })
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Resize with arrows
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Increase window height" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Decrease window height" })
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase window width" })
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease window width" })

-- smart-splits plugin
-- Resizing splits
map("n", "<M-h>", function() require("smart-splits").resize_left() end, { desc = "Grow split left" })
map("n", "<M-j>", function() require("smart-splits").resize_down() end, { desc = "Grow split down" })
map("n", "<M-k>", function() require("smart-splits").resize_up() end, { desc = "Grow split up" })
map("n", "<M-l>", function() require("smart-splits").resize_right() end, { desc = "Grow split right" })

-- Moving between splits
map("n", "<C-h>", function() require("smart-splits").move_cursor_left() end, { desc = "Move to the left split" })
map("n", "<C-j>", function() require("smart-splits").move_cursor_down() end, { desc = "Move to the split below" })
map("n", "<C-k>", function() require("smart-splits").move_cursor_up() end, { desc = "Move to the split above" })
map("n", "<C-l>", function() require("smart-splits").move_cursor_right() end, { desc = "Move to the right split" })

-- Note: Window resiging and navigation is handled by smart-splits plugin
-- These commented lines are given just in case because many people love them as is
-- Better window navigation
-- map("n", "<C-h>", "<C-w>h", { desc = "Move to the left window" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Move to the window above" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Move to the right window" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Move to the window below" })

-- swapping buffers between windows
map("n", "<leader><leader>h", function() require("smart-splits").swap_buf_left() end, { desc = "Swap with the left buffer" })
map("n", "<leader><leader>j", function() require("smart-splits").swap_buf_down() end, { desc = "Swap with the buffer below" })
map("n", "<leader><leader>k", function() require("smart-splits").swap_buf_up() end, { desc = "Swap with the buffer above" })
map("n", "<leader><leader>l", function() require("smart-splits").swap_buf_right() end, { desc = "Swap with the right buffer" })

-- Pay attention to the 3rd argument -- that's the default way to do splits, but it requires ctrl key
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- Tab navigation
-- Try using `gt` and `gT` to go to the next/prev tab
-- To go to the tab #N, use `Ngt`. First tab is `1gt`, the second one is `2gt`, etc
map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "[<tab>", "<cmd>tabprev<cr>", { desc = "Previous tab" })
map("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- Buffer navigation
map("n", "<leader>n", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>b", "<cmd>bprevious<cr>", { desc = "Previous buffer (= back)" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprev<cr>", { desc = "Previous buffer" })
map("n", "<leader>q", "<cmd>Bdelete!<cr>", { desc = "Close buffer" })
map("n", "<leader>j", "<cmd>BufferLinePick<cr>", { desc = "Jump to buffer (pick)" })
-- map("n", "<leader>X", "<cmd>BufferLinePickClose<cr>", { desc = "Pick which buffer to close" })

local function goto_buf(i)
  return function() require("bufferline").go_to(i) end
end

for i = 1, 9 do
  map("n", "<leader>" .. i, goto_buf(i), { desc = "Go to buffer #" .. i })
end
map("n", "<leader>$", goto_buf(-1), { desc = "Go to the last buffer" })

-- better-escape replacement: return to normal mode by rapidly pressing `jk`
-- Delete the keymap or decrease opt.timeoutlen in options.lua if false positives happen
map("i", "jk", "<esc>", { desc = "Return to Normal mode (sends <esc>)" })

-- Clear highlights
map("n", "<esc>", ":noh<cr>", { desc = "Clear highlights" })
map("n", "<leader>h", ":noh<cr>", { desc = "Clear highlights" })

-- Putting new lines without leaving Normal mode
map("n", "<leader>o", "mpo<esc>`p", { desc = "New line below (Normal mode)" })
map("n", "<leader>O", "mpO<esc>`p", { desc = "New line above (Normal mode)" })

-- Create new file
map("n", "New File", "<cmd>ene!<cr>", { desc = "New file" })

-- Save file with Ctrl + s, <leader>w, <leader>W
map({ "n", "x", "i" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file (:w)" })
-- SudaWrite
map("n", "<leader>W", "<cmd>SudaWrite<cr>", { desc = "Save file with Sudo" })

-- UI & Togglers
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle word wrapping" })
map("n", "<leader>ul", "<cmd>set number!<cr>", { desc = "Toggle line numbering" })
map("n", "<leader>ur", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative line numbering" })
map("n", "<leader>ut", "<cmd>set expandtab!<cr>", { desc = "Toggle spaces/tab in Insert mode" })
-- I think it's better to V-select your lines, do `!cat -A`, watch for strange characters, and undo `cat -A` with `u`
map("n", "<leader>uh", "<cmd>set list!<cr>", { desc = "Toggle tab/trailing spaces/nbsp visibility" })
map("n", "<leader>ui", function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hints" })

-- Interactive browsing & setting of any options -- when on a set line, hit Enter to cycle through the values
-- If changing a number/string, do the change in Insert mode and then hit Enter
map("n", "<leader>uo", "<cmd>options<cr>", { desc = "Interactive vim_options explorer" })

local function toggle_cmdheight()
  local h = 1 - vim.api.nvim_get_option("cmdheight")
  vim.api.nvim_set_option("cmdheight", h)
end

-- With cmdheight=0, when you type `:`, you type over the statusline.
-- When cmdheight=1, there is a separate line. Also, it shows partial commands as you type them
map("n", "<leader>uc", toggle_cmdheight, { desc = "Toggle cmdline visibility" })

local function toggle_autopairs()
    local autopairs = require("nvim-autopairs")
    if autopairs.state.disable then
        autopairs.enable()
    else
        autopairs.disable()
    end
end

map("n", "<leader>up", toggle_autopairs, { desc = "Toggle bracket pairing (autopairs)" })


-- Insert --
-- Navigation in Insert mode
map("i", "<C-h>", "<Left>", { desc = "Move cursor left" })
map("i", "<C-j>", "<Down>", { desc = "Move cursor down" })
map("i", "<C-k>", "<Up>", { desc = "Move cursor up" })
map("i", "<C-l>", "<Right>", { desc = "Move cursor right" })

-- Add undo break-points (so that `u` will undo up to comma, semicolon, and fullstop
-- <c-g>u = close undo sequence, start new change
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Visual (remember, it `x`, not `v`) --
-- Stay in indent mode (by default, < and > in Virtual mode result in switch to the Normal mode)
map("x", "<", "<gv", { desc = "Decrease indent and reselect the text" })
map("x", ">", ">gv", { desc = "Increase indent and reselect the text" })

map("x", "<leader>p", '"_dP', { desc = "Paste over w/o changing register" })
map("x", "p", "P", { desc = "Paste over the selected text" })
map("x", "<leader>D", "_d", { desc = "Delete without changing unnamed register" })

-- (Mainly) Plugins --

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree file browser" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files by path" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Search through files (live grep)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Search buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Search recently opened files" })
map("n", "<leader>fR", "<cmd>Telescope registers<cr>", { desc = "Search registers" })
map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "Search man pages" })
map("n", "<leader>fM", "<cmd>Telescope marks<cr>", { desc = "Search marks" })
map("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Search jumplist" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Search NeoVim commands" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Search NeoVim help pages" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find <cr>", { desc = "Find in the current buffer" })
map("n", "<leader>fo", "<cmd>Telescope vim_options<cr>", { desc = "Search config options" })
map("n", "<leader>fa", "<cmd>Telescope autocommands<cr>", { desc = "Search autocommands" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Search commands" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cR>", { desc = "Search keymaps" })
-- Also, `<leader>fE` and `<leader>fe` to open mini.files file explorer [lua/plugins/mini-files.lua]

map("n", "<leader>U", "<cmd>Telescope undo<cr>", { desc = "Search through undo history" })

-- Aerial
map("n", "<leader>fs", "<cmd>AerialToggle!<cr>", { desc = "Toggle symbols explorer" })

-- Todo comments (find block)
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "List TODO/FIX/etc (Telescope)" })
map("n", "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme (Telescope)" })

-- Spectre (find & replace like `sed` -- hence the first letter)
map("n", "<leader>sr", function() require("spectre").open() end, { desc = "Replace in files (Spectre)" })
map("n", "<leader>sb", function() require("spectre").open_file_search({ select_word = true }) end, { desc = "Replace in the buffer (Spectre)" })

-- Git
map("n", "<leader>gg", function() _LAZYGIT_TOGGLE() end, { desc = "Toggle LazyGit" })
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Search through git status" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches (checkout on <cr>)" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits (checkout on <cr>)" })
map("n", "<leader>gC", "<cmd>Telescope git_bcommits<cr>", { desc = "Git commits for the buffer (c/o on <cr>)" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", { desc = "Git Diff w/HEAD" })
map("n", "<leader>gl", function() require("gitsigns").blame_line() end, { desc = "Blame (this one line)" })
map("n", "<leader>gL", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle git blame (current line)" })

-- Git hunks (prev/next hunk duplicated to support two popular keybind choices)
map("n", "<leader>ghj", function() require("gitsigns").next_hunk({ navigation_message = false }) end, { desc = "Next git hunk" })
map("n", "<leader>ghk", function() require("gitsigns").prev_hunk({ navigation_message = false }) end, { desc = "Previous git hunk" })
map("n", "]h", function() require("gitsigns").next_hunk() end, { desc = "Next git hunk" })
map("n", "[h", function() require("gitsigns").prev_hunk() end, { desc = "Previous git hunk" })
map("n", "<leader>ghp", function() require("gitsigns").preview_hunk() end, { desc = "Preview Hunk" })
map("n", "<leader>ghr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Hunk" })
map("n", "<leader>ghR", function() require("gitsigns").reset_buffer() end, { desc = "Reset Buffer" })
map("n", "<leader>ghs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Hunk" })
map("n", "<leader>ghu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Undo Stage Hunk" })

-- Comments (I recommend `gcc` and `gcb`, but `<leader>/` keymap is quite popular)
map("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle comment" })

-- Stable `<leader>/` in visual (x) mode is surpisingly hard: here, we take the actual escape sequaence for <ESC>
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
map("x", "<leader>/", function()
  -- Now, we need to comment lines as if it was in a normal mode
  -- See https://github.com/neovim/neovim/issues/17735 and https://github.com/neovim/neovim/issues/13781
  vim.api.nvim_feedkeys(esc, 'nx', false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment" })

-- DAP (LazyVim-inspired)
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Condition-based breakpoint" })
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Run/Continue" })
map("n", "<leader>dC", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
map("n", "<leader>dk", function() require("dap").up() end, { desc = "Up" })
map("n", "<leader>dj", function() require("dap").down() end, { desc = "Down" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
map("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<leader>dO", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<leader>dp", function() require("dap").pause() end, { desc = "Pause" })
map("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle debug REPL" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run last" })
map("n", "<leader>ds", function() require("dap").session() end, { desc = "Debugging session" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })
map("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate DAP" })
map("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Dap UI Widgets" })
map({ "n", "x" }, "<leader>de", function() require("dapui").eval() end, { desc = "Dap UI Eval" })

-- Lsp
map({ "n", "x" }, "<leader>lf", function() vim.lsp.buf.format { async = true } end, { desc = "Format code (LSP)" })
map("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration (LSP)" })
map("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition (LSP)" })
map("n", "gI", function() vim.lsp.buf.implementation() end, { desc = "Go to impementation (LSP)" })
map("n", "gr", function() vim.lsp.buf.references() end, { desc = "Go to references (LSP)" })
map("n", "gl", function() vim.diagnostic.open_float() end, { desc = "Open diagnostics window (LSP)" })
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP Information" })
map({ "n", "x" }, "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "Code actions (LSP)" })
map("n", "<leader>lj", function() vim.diagnostic.goto_next({ buffer = 0 }) end, { desc = "Go to next diagnostics (LSP)" })
map("n", "<leader>lk", function() vim.diagnostic.goto_prev({ buffer = 0 }) end, { desc = "Go to previous diagnostics (LSP)" })
map("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "Rename (LSP)" })
map("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, { desc = "Signature help (LSP)" })
map("n", "<leader>lq", function() vim.diagnostic.setloclist() end, { desc = "Diagnostics loclist (LSP)" })

-- The default LSP `K` is the following:
-- map("n", "K", function() vim.lsp.buf.hover() end, { desc = "" })

-- Overriding `K` to support man and help docs, lsp hover, and popup cargo documentation
local function show_documentation()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
    require("crates").show_popup()
  else
    vim.lsp.buf.hover()
  end
end

map("n", "K", show_documentation, { desc = "Show man/vim/help/crates.io docs", silent = true })

-- Trouble.nvim
map("n", "<leader>xx", function() require("trouble").open() end, { desc = "Toggle Trouble" })
map("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end, { desc = "Workspace diagnostics (Trouble)" })
map("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end, { desc = "Document diagnostics (Trouble)" })
map("n", "<leader>xl", function() require("trouble").open("loclist") end, { desc = "Location list (Trouble)" })
map("n", "<leader>xq", function() require("trouble").open("quickfix") end, { desc = "Quickfix lit (Trouble)" })
map("n", "gR", function() require("trouble").open("lsp_references") end, { desc = "LSP references (Trouble)" })
map("n", "]q", function() require("trouble").next({ skip_groups = true, jump = true }) end, { desc = "Next trouble/quickfix item" })
map("n", "[q", function() require("trouble").previous({ skip_groups = true, jump = true }) end, { desc = "Previous trouble/quickfix item"})

-- todo-comments.nvim (Trouble block)
map("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "List TODO/FIX/etc (Trouble)" })
map("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", { desc = "Todo (Trouble)" })
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })

-- Toggleterm
-- `<c-\>` to toggle floating terminal, see lua/plugins/toggleterm.lua 
map("n", "<leader>ti", function() _IPY_TOGGLE() end, { desc = "Toggle iPython terminal" })
map("n", "<leader>tb", function() _BTOP_TOGGLE() end, { desc = "Toggle btop terminal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
map("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", { desc = "Toggle terminal tab" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
map("n", "<leader>tv", "<cmd>ToggleTerm size=50 direction=vertical<cr>", { desc = "Toggle vertical terminal" })
map("n", "<leader>t2h", "<cmd>2 ToggleTerm direction=horizontal<cr>", { desc = "Toggle 2nd horizontal terminal" })
map("n", "<leader>t2v", "<cmd>2 ToggleTerm size=50 direction=vertical<cr>", { desc = "Toggle 2nd vertical terminal" })

-- zen mode
map("n", "<leader>z", function() return require("zen-mode").toggle() end, { desc = "Toggle Zen mode" })

-- Mini.Sessions (note: there is no need for manual saving because of MiniSession.config.autosave = true)
map("n", "<leader>sr", function() require("mini.sessions").read(nil) end, { desc = "Load local or latest global session" })
map("n", "<leader>sR", function() require("mini.sessions").select("read") end, { desc = "Select & load a session" })
-- Note: if session exists and is loaded, it autosaves on exit. So, there is no need to explicitly save existing session
-- except when expecting crash, force reboot, etc. In this case, use `sW`.
-- The intent of `sw` command is to create a new local session
map("n", "<leader>sw", function() local M = require("mini.sessions"); M.write(M.config.file) end, { desc = "Write a local session" })
map("n", "<leader>sW", function() require("mini.sessions").select("write") end, { desc = "Select & write a session" })
map("n", "<leader>sd", function() require("mini.sessions").delete(nil) end, { desc = "Delete current session" })
map("n", "<leader>sD", function() require("mini.sessions").select("delete") end, { desc = "Select & delete a session" })

-- Custom keybinds set in other places:

-- lua/plugins/better-escape.lua
--   `jj` and `jk` in Insert mode switch to the Normal mode

-- lua/plugins/cmp.lua
--   `<C-k>` and `<C-j>` to go to the next/prev autocomplete option
--   `<C-b>` and `<C-f>` to scroll popup documentation 
--   `<C-space>` for incremental search, 
--   `<CR>` to select and accept, `<C-e>` to close/abort, `<tab>` and `<S-tab>` to select next/prev and maybe expand

-- lua/plugins/mini-surround.lua
--   Same as default, but prefix `s` is replaced with `gz`. For example, `sa` is `gza`

-- lua/plugins/clangd_extensions.lua
--   `<leader>T` for `ClangdSwitchSourceHeader` to Toggle Source/Header file (C/C++) 

-- lua/plugins/mini-files.lua
--   `<leader>fE` and `<leader>fe` to open mini.files file explorer 

-- lua/plugins/mini-move.lua
--   `<M-H>`, `<M-J>`, `<M-K>`, `<M-L>`: move selection or line with Alt/Meta + Shift + h/j/k/l

-- lua/autocommands.lua
--   `q` to close "service" buffers like man, lspinfo, help, etc

-- lua/plugins/flash-nvim.lua
--   `s` and `r` for search and remote search, `S` and `R` for treesitter (syntactic) search and remote search

-- lua/plugins/autopairs.lua
--   `<M-e>` for (FastWrapping)

-- lua/plugins/toggleterm.lua
--   `<C-\>` to toggle floating terminal
--   `jk` (go to normal mode) and Ctrl + h/j/k/l for terminal navigation

-- lua/plugins/nvim-tree.lua
--   `l`, `<CR>`, `o` to open files, `h` to collape directories, `v` to open in a vertical split


-- EdenVim configuration & options
-- TODO: view logs, EdenVim version, lazy, mason, updates, themes (?), open docs, keybind cheatsheet
