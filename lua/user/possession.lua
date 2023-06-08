local M = {
  "jedrzejboczar/possession.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VimEnter",
}

M.opts = {
  -- session_dir = (Path:new(vim.fn.stdpath("data")) / "possession"):absolute(),
  autosave = {
    current = true,  -- or fun(name): boolean
    tmp = true,      -- or fun(): boolean
    tmp_name = "autosave",
    on_load = true,
    on_quit = true,
  },
  commands = {
    save = "SSave",
    load = "SLoad",
    delete = "SDelete",
    close = "SClose",
    rename = "SRename",
    list = "SList",
  },
  telescope = {
    list = {
      default_action = "load",
      mappings = {
        save = { n = "<c-s>", i = "<c-s>" },
        load = { n = "<c-l>", i = "<c-l>" },
        delete = { n = "<c-x>", i = "<c-x>" },
        rename = { n = "<c-r>", i = "<c-r>" },
      },
    },
  },
}

function M.config(_, opts)
  require("possession").setup(opts)
  require("telescope").load_extension("possession")
end

return M
