local M = {
  "nvim-lualine/lualine.nvim",
  commit = "0050b308552e45f7128f399886c86afefc3eb988",
  event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
}

function M.config()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  -- local hide_in_width = function()
  --   return vim.fn.winwidth(0) > 80
  -- end

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = { error = " ", warn = " ", info = " ", hint = " "},
    colored = true,
    update_in_insert = true,
    always_visible = false,
  }

  local diff = {
    "diff",
    colored = true,
    symbols = { added = "+", modified = "~", removed = "-" }, -- changes diff symbols
    -- cond = hide_in_width,
  }

  local filename = {
    "filename",
    file_status = true,
    path = 1,
  }

  local filetype = {
    "filetype",
    icons_enabled = true,
  }

  local location = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    "%7(%l/%L%):%-3c",
  }

  -- local lsp = {
  --   function()
  --     print(vim.sdfs)
  --     local names = {}
  --     for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
  --       table.insert(names, server.name)
  --     end
  --     if #names == 0 then
  --       return ""
  --     elseif #names == 1 then
  --       return names[1]
  --     end
  --     return "[" .. table.concat(names, " ") .. "]"
  --   end,
  --   icon = " ",
  -- }

  local session = {
    function()
      return require("possession.session").session_name or ""
    end,
    icon = "󰃀",
  }

  local date = {
    function()
      return os.date("%a %m/%d %H:%M")
    end,
    -- icon = "",
  }

  -- local spaces = function()
  --   return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  -- end

  lualine.setup {
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "|" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "dashboard" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", diff },
      lualine_c = { diagnostics, session, filename },
      lualine_x = { "fileformat", "encoding", filetype },
      lualine_y = { location },
      lualine_z = { date },
    },
  }
end

return M
