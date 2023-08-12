-- IDE-like file explorer usually used as a sidebar
-- Note: for selecting files and buffers, consider Telescope's `ff`, `fb`, and other key binds
-- For filesystem manipulations like file tree creation try mini.files (lua/plugins/mini-files.lua).
-- Note 2: if you want nvim/tab to automatically close when Nvim-tree is the last buffer, 
-- refer to https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
-- https://github.com/nvim-tree/nvim-tree.lua

local M = {
  "kyazdani42/nvim-tree.lua",
  enabled = true,
  event = "VimEnter",
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
      update_cwd = true,
    },
    git = {
      enable = false, -- Should git signs be drawn on the files?
      ignore = true,
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    renderer = {
      indent_markers = {
        enable = false,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false,
        },
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    diagnostics = {
      enable = false, -- Should diagnostics (warnings, etc) be shown on the tree?
      show_on_dirs = false, -- Propagate diagnostics info signs to the containing directories
    },
    view = {
      width = 30,
      side = "left",
    },
  },
}

-- Setting non-default key bindings
local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
end

function M.config(_, opts)
  opts.on_attach = on_attach
  require("nvim-tree").setup(opts)
end

return M
