-- Adaptation of https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/theta.lua

local path_ok, plenary_path = pcall(require, "plenary.path")
if not path_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"

-- Header section

local headers = {}
headers.small = {
  " ███████ ██████  ███████ ███    ██ ██    ██ ██ ███    ███ ",
  " ██      ██   ██ ██      ████   ██ ██    ██ ██ ████  ████ ",
  " █████   ██   ██ █████   ██ ██  ██ ██    ██ ██ ██ ████ ██ ",
  " ██      ██   ██ ██      ██  ██ ██  ██  ██  ██ ██  ██  ██ ",
  " ███████ ██████  ███████ ██   ████   ████   ██ ██      ██ ",
}

headers.big = {
  "     ***** **         **                                ***** *      **                            ",
  "  ******  **** *       **                            ******  *    *****     *                      ",
  " **   *  * ****        **                           **   *  *       *****  ***                     ",
  "*    *  *   **         **                          *    *  **       * **    *                      ",
  "    *  *               **                              *  ***      *                               ",
  "   ** **           *** **      ***    ***  ****       **   **      *      ***     *** **** ****    ",
  "   ** **          *********   * ***    **** **** *    **   **      *       ***     *** **** ***  * ",
  "   ** ******     **   ****   *   ***    **   ****     **   **     *         **      **  **** ****  ",
  "   ** *****      **    **   **    ***   **    **      **   **     *         **      **   **   **   ",
  "   ** **         **    **   ********    **    **      **   **     *         **      **   **   **   ",
  "   *  **         **    **   *******     **    **       **  **    *          **      **   **   **   ",
  "      *          **    **   **          **    **        ** *     *          **      **   **   **   ",
  "  ****         * **    **   ****    *   **    **         ***     *          **      **   **   **   ",
  " *  ***********   *****      *******    ***   ***         *******           *** *   ***  ***  ***  ",
  "*     ******       ***        *****      ***   ***          ***              ***     ***  ***  *** ",
}

local header = {
  type = "text",
  val = headers[vim.g.eden_header] or headers.small,
  opts = { position = "center", hl = "DashboardHeader" },
}

-- Buttons section

local button = function(...)
  local create_button = require("alpha.themes.dashboard").button
  local b = create_button(...)
  b.opts.hl = "DashboardCenter"
  b.opts.hl_shortcut = "DashboardShortCut"
  return b
end

--- Open session, creating it if it doesn't exist yet
local function ensure_session(session_name, path)
  local ms = require('mini.sessions')

  if not ms.detected[session_name] then
    vim.cmd('cd ' .. path)
    ms.write(session_name)
  end
  ms.read(session_name, { force = true })
end

-- Assume for an example that dotfiles are directly above nvim config dir that Neovim uses
local nvim_dir = vim.fn.stdpath('config')
local dots_dir = nvim_dir:gsub('/nvim$', '')

local buttons = {
  type = "group",
  val = {
    { type = "text",    val = "Quick Actions", opts = { hl = "DashboardShortCut", position = "center" } },
    { type = "padding", val = 1 },

    -- BAR is just '|' used to separate commands in command mode
    button("e", "󰝒 " .. " New file", "<cmd>enew <BAR> startinsert<cr>"),

    button("f", "󰱼 " .. " Find file", "<cmd>Telescope find_files<cr>"),
    button("r", "󱋡 " .. " Recent files", "<cmd>Telescope oldfiles<cr>"),
    button("g", "󱎸 " .. " Grep in files", "<cmd>Telescope live_grep<cr>"),
    button("m", "󰸕 " .. " Marks", "<cmd>Telescope marks<cr>"),
    -- You can use 'pass-trough' keybindings for better discoverability
    -- They match with the actual keymaps you'll use outside the dashboard
    -- button("SPC f f", "󰱼 " .. " Find file"),
    -- button("SPC f r", "󱋡 " .. " Recent files"),
    -- button("SPC f g", "󱎸 " .. " Grep in files"),
    -- button("SPC f m", "󰸕 " .. " Marks"),

    -- With Lua code, remember to wrap actions in a function to defer execution
    button("s", "󰀄 " .. " Sessions", function() require('mini.sessions').select("read") end),
    button("c", " " .. " EdenVim config", function() ensure_session("nvim", nvim_dir) end),
    button("d", " " .. " Dotfiles", function() ensure_session("dotfiles", dots_dir) end),

    button("l", "󰒲 " .. " Plugins (lazy.nvim)", "<cmd>Lazy<cr>"),
    button("q", "󰩈 " .. " Quit", "<cmd>qa!<cr>"),
  },
  position = "center",
}

-- MRU section helpers

local cdir = vim.fn.getcwd()
local if_nil = vim.F.if_nil

local function icon(fn)
  local match = fn:match "^.+(%..+)$"
  local ext = ""
  if match ~= nil then
    ext = match:sub(2)
  end
  return require("nvim-web-devicons").get_icon(fn, ext, { default = true })
end

local function button_mru(filepath, filepath_short, shortcut)
  filepath_short = filepath_short or filepath
  local ico, _ = icon(filepath)
  local ico_txt = ico .. "  "
  local button_highlights = {}
  local file_button_el = button(shortcut, ico_txt .. filepath_short, "<cmd>e " .. filepath .. " <CR>")
  local filename_pos = filepath_short:match ".*[/\\]"
  table.insert(button_highlights, { "DashboardCenter", 0, #ico_txt + #filepath_short })
  if filename_pos ~= nil then
    table.insert(button_highlights, { "DashboardShortCut", #ico_txt - 2, #filename_pos + #ico_txt })
  end
  file_button_el.opts.hl = button_highlights
  return file_button_el
end

local function mru(start, cwd, items_number)
  items_number = if_nil(items_number, 10)

  local oldfiles = {}
  for _, v in pairs(vim.v.oldfiles) do
    if #oldfiles == items_number then
      break
    end
    local cwd_cond
    if not cwd then
      cwd_cond = true
    else
      cwd_cond = vim.startswith(v, cwd)
    end
    if (vim.fn.filereadable(v) == 1) and cwd_cond then
      oldfiles[#oldfiles + 1] = v
    end
  end
  local target_width = 35

  local tbl = {}
  for i, fn in ipairs(oldfiles) do
    local short_fn
    if cwd then
      short_fn = vim.fn.fnamemodify(fn, ":.")
    else
      short_fn = vim.fn.fnamemodify(fn, ":~")
    end

    if #short_fn > target_width then
      short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
      if #short_fn > target_width then
        short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
      end
    end

    local shortcut = tostring(i + start - 1)

    local file_button_el = button_mru(fn, short_fn, shortcut)
    tbl[i] = file_button_el
  end
  return { type = "group", val = tbl, opts = {} }
end

-- MRU section

local section_mru = {
  type = "group",
  val = {
    {
      type = "text",
      val = "Recent files",
      opts = {
        hl = "DashboardShortCut",
        shrink_margin = false,
        position = "center",
      },
    },
    { type = "padding", val = 1 },
    {
      type = "group",
      val = function()
        return { mru(0, cdir) }
      end,
      opts = { shrink_margin = false },
    },
  },
}

-- Alpha config

local config = {
  layout = {
    { type = "padding", val = 1 },
    header,
    { type = "padding", val = 2 },
    buttons,
    { type = "padding", val = 1 },
    section_mru,
  },
  opts = {
    margin = 5,
    setup = function()
      vim.api.nvim_create_autocmd("DirChanged", {
        pattern = "*",
        group = "alpha_temp",
        callback = function()
          require("alpha").redraw()
        end,
      })
    end,
  },
}

return {
  header = header,
  buttons = buttons,
  mru = mru,
  config = config,
  leader = dashboard.leader,
}
