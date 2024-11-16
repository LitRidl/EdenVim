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

-- smart-splits plugin
-- Resizing splits
-- Keymaps accept ranges: `5<M-h>` will grow left by 5 times the default amount
map("n", "<M-h>", function() require("smart-splits").resize_left() end, { desc = "Grow split left" })
map("n", "<M-j>", function() require("smart-splits").resize_down() end, { desc = "Grow split down" })
map("n", "<M-k>", function() require("smart-splits").resize_up() end, { desc = "Grow split up" })
map("n", "<M-l>", function() require("smart-splits").resize_right() end, { desc = "Grow split right" })

-- Moving between splits
map("n", "<C-h>", function() require("smart-splits").move_cursor_left() end, { desc = "Switch to the left split" })
map("n", "<C-j>", function() require("smart-splits").move_cursor_down() end, { desc = "Switch to the split below" })
map("n", "<C-k>", function() require("smart-splits").move_cursor_up() end, { desc = "Switch to the split above" })
map("n", "<C-l>", function() require("smart-splits").move_cursor_right() end, { desc = "Switch to the right split" })

-- Note that Ctl+w followed by s or v is the built-in way to do splits, which is just proxied here
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
-- Ise Ctrl+6 and Ctrl+^ for switching alternate buffers (usually it's just last buffer)
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprev<cr>", { desc = "Previous buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Previous buffer" })

-- Mnemonics: `,` for deliberate search, `.` for immediate jump (like in typing)
map("n", "<leader>.", "<cmd>BufferLinePick<cr>", { desc = "Quick pick buffer" })
map("n", "<leader>,", "<cmd>Telescope buffers<cr>", { desc = "Search buffers (Telescope)" })

map("n", "<leader>q", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
map("n", "<leader>Q", "<cmd>Bdelete!<cr>", { desc = "Close buffer (force)" })

-- map("n", "<leader>X", "<cmd>BufferLinePickClose<cr>", { desc = "Pick which buffer to close" })

-- Moving buffers between windows (buffer shown in the current window is swapped with the buffer in an adjacent window)
map("n", "<leader>bh", function() require("smart-splits").swap_buf_left() end, { desc = "Swap buffer with left window" })
map("n", "<leader>bj", function() require("smart-splits").swap_buf_down() end, { desc = "Swap buffer with window below" })
map("n", "<leader>bk", function() require("smart-splits").swap_buf_up() end, { desc = "Swap buffer with window above" })
map("n", "<leader>bl", function() require("smart-splits").swap_buf_right() end, { desc = "Swap buffer with right window" })

local function goto_buf(i)
  return function() require("bufferline").go_to(i) end
end

-- Note: for faster typing, I prefer `<leader>b` and `<leader>n` for prev/next buffer 
--       and <leader>1` to `<leader>9` for the specific buffers. You may want to try it.
-- Also, there are built-in commands `:bn` and `:bp` to go to the next/prev buffer
for i = 1, 5 do
  map("n", "<leader>b" .. i, goto_buf(i), { desc = "Go to buffer #" .. i })
end
map("n", "<leader>b$", goto_buf(-1), { desc = "Go to the last buffer" })

-- better-escape replacement: return to normal mode by rapidly pressing `jk`
-- Delete the keymap or decrease opt.timeoutlen in options.lua if false positives happen
map("i", "jk", "<esc>", { desc = "Return to Normal mode (sends <esc>)" })

-- Clear highlights
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear highlights and Escape" })

-- Put new lines without leaving Normal mode and moving cursor -- uncomment if you want it
-- map("n", "<leader>o", "mpo<esc>`p", { desc = "New line below (Normal mode)" })
-- map("n", "<leader>O", "mpO<esc>`p", { desc = "New line above (Normal mode)" })

-- Pasting and Deleting without changing the register
map("x", "<leader>p", '"_dP', { desc = "Paste over w/o changing register" })
map("x", "<leader>D", "_d", { desc = "Delete without changing unnamed register" })

-- Create new file
map("n", "New File", "<cmd>ene!<cr>", { desc = "New file" })

-- Save file with Ctrl + s, <leader>w, <leader>W
map({ "n", "x", "i" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file (:w)" })
-- SudaWrite
map("n", "<leader>W", "<cmd>SudaWrite<cr>", { desc = "Save file with Sudo" })

-- Options, UI, Toggles
map("n", "<leader>ow", "<cmd>set wrap!<cr>", { desc = "Toggle word wrapping" })
map("n", "<leader>ol", "<cmd>set number!<cr>", { desc = "Toggle line numbering" })
map("n", "<leader>or", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative line numbering" })
map("n", "<leader>ot", "<cmd>set expandtab!<cr>", { desc = "Toggle spaces/tab in Insert mode" })
-- I think it's better to V-select your lines, do `!cat -A`, watch for strange characters, and undo `cat -A` with `u`
map("n", "<leader>oc", "<cmd>set list!<cr>", { desc = "Toggle hidden character visibility" })
map("n", "<leader>oh", function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hints" })
map("n", "<leader>os", "<cmd>AerialToggle!<cr>", { desc = "Toggle symbols explorer (Aerial)" })

-- Interactive browsing & setting of any options -- when on a set line, hit Enter to cycle through the values
-- If changing a number/string, do the change in Insert mode and then hit Enter
map("n", "<leader>oo", "<cmd>options<cr>", { desc = "Interactive vim_options explorer" })

local function toggle_cmdheight()
  local h = 1 - vim.api.nvim_get_option("cmdheight")
  vim.api.nvim_set_option("cmdheight", h)
end

-- With cmdheight=0, when you type `:`, you type over the statusline.
-- When cmdheight=1, there is a separate line. Also, it shows partial commands as you type them
map("n", "<leader>oc", toggle_cmdheight, { desc = "Toggle cmdline visibility" })

local function toggle_autopairs()
    local autopairs = require("nvim-autopairs")
    if autopairs.state.disable then
        autopairs.enable()
    else
        autopairs.disable()
    end
end

map("n", "<leader>op", toggle_autopairs, { desc = "Toggle bracket pairing (autopairs)" })


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

-- (Mainly) Plugins --

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file browser (nvim-tree)" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files by path" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recently opened files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Search text in files (grep)" })
map("n", "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find <cr>", { desc = "Search in current buffer" })

map("n", "<leader>fR", "<cmd>Telescope registers<cr>", { desc = "Find registers" })
map("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
map("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Search jumplist" })
map("n", "<leader>fc", "<cmd>Telescope command_history<cr>", { desc = "Search command history" })
-- See lua/plugins/mini-files.lua: it adds `<leader>fE` and `<leader>fe` to open mini.files file explorer

-- Todo comments (keywords like TODO, HACK, WARN, WARNING, FIX, FIXME, BUG, NOTE, INFO, TEST, PERF)
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODO/FIX/etc comments" })

map("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Undo history" })

-- Spectre (find & replace)
map("n", "<leader>rf", function() require("spectre").open() end, { desc = "Replace in files (Spectre)" })
map("n", "<leader>rb", function() require("spectre").open_file_search({ select_word = true }) end, { desc = "Replace in the buffer (Spectre)" })

-- Lsp
map({ "n", "x" }, "<leader>lf", function() vim.lsp.buf.format { async = true } end, { desc = "Format code (LSP)" })
map("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration (LSP)" })
map("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition (LSP)" })
map("n", "gI", function() vim.lsp.buf.implementation() end, { desc = "Go to impementation (LSP)" })
map("n", "gr", function() vim.lsp.buf.references() end, { desc = "Go to references (LSP)" })
map("n", "gl", function() vim.diagnostic.open_float() end, { desc = "Open diagnostics window (LSP)" })
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP Information" })
map({ "n", "x" }, "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "Code actions (LSP)" })
-- Try [d and ]d instead of <leader>ln and <leader>lp
map("n", "<leader>ln", function() vim.diagnostic.goto_next({ buffer = 0 }) end, { desc = "Go to next diagnostics (LSP)" })
map("n", "<leader>lp", function() vim.diagnostic.goto_prev({ buffer = 0 }) end, { desc = "Go to previous diagnostics (LSP)" })
map("n", "<leader>lr", function() vim.lsp.buf.rename() end, { desc = "Rename (LSP)" })
map("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, { desc = "Signature help (LSP)" })
map("n", "<leader>lq", function() vim.diagnostic.setloclist() end, { desc = "Diagnostics loclist (LSP)" })

-- Help and config info
map("n", "<leader>hn", "<cmd>Telescope help_tags<cr>", { desc = "Find NeoVim help pages" })
map("n", "<leader>ho", "<cmd>Telescope vim_options<cr>", { desc = "Find config options" })
map("n", "<leader>hm", "<cmd>Telescope man_pages<cr>", { desc = "Find man pages" })

map("n", "<leader>ha", "<cmd>Telescope autocommands<cr>", { desc = "Find autocommands" })
map("n", "<leader>hc", "<cmd>Telescope commands<cr>", { desc = "Find NeoVim commands" })
map("n", "<leader>hk", "<cmd>Telescope keymaps<cR>", { desc = "Find keymaps" })

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

map("n", "K", show_documentation, { desc = "Show man/vim/help/crates docs", silent = true })

-- Trouble.nvim, diagnostics, quickfix/loclist, lsp_references, TODO comments
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Workspace diagnostics (Trouble)" })
map("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics (Trouble)" })
map("n", "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references (Trouble)" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list (Trouble)" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list (Trouble)" })
map("n", "gR", function() require("trouble").toggle("lsp_references") end, { desc = "LSP references (Trouble)" })
map("n", "]q", function() require("trouble").next({ skip_groups = true, jump = true }) end, { desc = "Next trouble/quickfix item" })
map("n", "[q", function() require("trouble").prev({ skip_groups = true, jump = true }) end, { desc = "Previous trouble/quickfix item"})

-- todo-comments.nvim (Trouble.nvim integration)
map("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "List TODO/FIX/etc (Trouble)" })
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
-- Second terminal commands
-- map("n", "<leader>t2h", "<cmd>2 ToggleTerm direction=horizontal<cr>", { desc = "Toggle 2nd horizontal terminal" })
-- map("n", "<leader>t2v", "<cmd>2 ToggleTerm size=50 direction=vertical<cr>", { desc = "Toggle 2nd vertical terminal" })

-- zen mode
map("n", "<leader>z", function() return require("zen-mode").toggle() end, { desc = "Toggle Zen mode" })

-- Mini.Sessions (note: there is no need for manual saving because of MiniSession.config.autosave = true)
map("n", "<leader>sl", function() require("mini.sessions").read(nil) end, { desc = "Load local or latest global session" })
map("n", "<leader>sp", function() require("mini.sessions").select("read") end, { desc = "Pick & load a session" })
-- Note: if session exists and is loaded, it autosaves on exit. So, there is no need to explicitly save existing session
-- except when expecting crash, force reboot, etc. In this case, use `sW`.
-- The intent of `sw` command is to create a new local session
map("n", "<leader>sw", function() local M = require("mini.sessions"); M.write(M.config.file) end, { desc = "Write a local session" })
map("n", "<leader>sW", function() require("mini.sessions").select("write") end, { desc = "Select & write a session" })
map("n", "<leader>sd", function() require("mini.sessions").delete(nil) end, { desc = "Delete current session" })
map("n", "<leader>sD", function() require("mini.sessions").select("delete") end, { desc = "Select & delete a session" })

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

-- Stable `<leader>/` in visual (x) mode is surpisingly hard: here, we take the actual escape sequence for <ESC>
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
