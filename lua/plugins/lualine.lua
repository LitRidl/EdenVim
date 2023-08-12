-- Statusline (git branch, filename, tab width, etc)
-- https://github.com/nvim-lualine/lualine.nvim

local M = {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  event = { "VimEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
}

function M.config()
  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    colored = true,
    update_in_insert = true,
    always_visible = false,
  }

  local diff = {
    "diff",
    colored = true,
    symbols = { added = "+", modified = "~", removed = "-" }, -- changes diff symbols
  }

  local filename = {
    "filename",
    file_status = true,
    path = 1,
  }

  local eol_format = {
    "fileformat",
    symbols = {   -- Text alternatives:
      unix = "", -- "NL"
      dos = "",  -- "CR NL"
      mac = "",  -- "CR"
    },
  }

  -- Spaces per indent
  local shiftwidth = {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      return "󰌒 " .. shiftwidth
    end,
    on_click = function()
      local spaces = vim.api.nvim_buf_get_option(0, "shiftwidth") + 2
      if spaces > 8 then
        spaces = 2
      end
      vim.api.nvim_buf_set_option(0, "shiftwidth", spaces)
    end,
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
    -- If you don't like statuline "jiggling" during navigation, set fixed width for location
    -- "%7(%l/%L%):%-3c",
    "%(%l/%L%):%c",
  }

  local datetime = {
    "datetime",
    style = "%a %m/%d %H:%M",
    -- icon = "",
  }

  local searchcount = {
    "searchcount",
    maxcount = 999,
    timeout = 500,
    icon = "",
  }

  -- Session name
  -- local session = {
  --   "%{fnamemodify(v:this_session,':t')}",
  -- }

  require("lualine").setup {
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" }, -- right = "│"
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "dashboard" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", diff },
      lualine_c = {
        diagnostics,
        -- session,
        filename,
      },
      lualine_x = { eol_format, shiftwidth, "encoding", filetype },
      lualine_y = { searchcount, location },
      lualine_z = { datetime },
    },
  }
end

return M
