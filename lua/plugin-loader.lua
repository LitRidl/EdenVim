-- Clone lazy.nvim if not found in system
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  install = {
    missing = true,
    colorscheme = { require("colorschemes.gruvbox").name },
  },
  -- Directory for your local plugins. Uncomment if you'd like to use this feature -- useful when developing plugins
  -- dev = { path = "~/nvim/projects" },
  defaults = {
    lazy = true,
  },
  ui = { wrap = "true" },
  change_detection = { enabled = true },
   -- automatically check for plugin updates
  checker = { enabled = false },
  debug = false,
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        -- -- Disabled in many distros to cut few msec of startup time, but it allows remote development:
        -- -- `nvim scp://root@server//etc/nginx/` will open a remote folder and sync changes, pure ssh
        -- "netrwPlugin",
        "gzip",
        "tarPlugin",
        "zipPlugin",
        "tohtml",
        -- "matchit",
        -- "matchparen",
        -- "tutor",
      },
    },
  },
}

-- all *.lua files within each directory specified here are considered plugin files
-- Note: if you want to include plugins/subfolder/*.lua files, add { import = "plugins/subfolder" }
local import_dirs = {
  { import = "colorschemes" },
  { import = "plugins" },
}

require("lazy").setup(import_dirs, opts)
