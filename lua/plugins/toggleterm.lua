-- Terminal management
-- https://github.com/akinsho/toggleterm.nvim

local M = {
  "akinsho/toggleterm.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "single",
    },
  },
}

function M.config(_, opts)
  local toggleterm = require "toggleterm"

  toggleterm.setup(opts)

  function _G.set_terminal_keymaps()
    local opts = { noremap = true, buffer = 0 }
    -- <esc> is preserved for terminal emulator's vim mode
    vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
  end

  vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

  local Terminal = require("toggleterm.terminal").Terminal

  local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end

  local btop = Terminal:new { cmd = "btop", hidden = true }
  function _BTOP_TOGGLE()
    btop:toggle()
  end

  local ipython = Terminal:new { cmd = "ipython", hidden = true }
  function _IPY_TOGGLE()
    ipython:toggle()
  end
end

return M
