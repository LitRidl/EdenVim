local M = {
  "akinsho/toggleterm.nvim",
  commit = "19aad0f41f47affbba1274f05e3c067e6d718e1e",
  event = "VeryLazy",
}

function M.config()
  local status_ok, toggleterm = pcall(require, "toggleterm")
  if not status_ok then
    return
  end

  toggleterm.setup {
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
  }

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
