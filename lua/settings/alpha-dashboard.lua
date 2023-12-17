-- Adaptation of https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/theta.lua

local path_ok, plenary_path = pcall(require, "plenary.path")
if not path_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"

-- Header section

local header = {
  type = "text",
  val = {
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
    "*                                                                                                  ",
    " **                                                                                                ",
  },
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

local buttons = {
  type = "group",
  val = {
    { type = "text", val = "Quick Actions", opts = { hl = "DashboardShortCut", position = "center" } },
    { type = "padding", val = 1 },
    button("e", "󰝒 " .. " New file", ":ene <BAR> startinsert<cr>"),
    button("f", "󰱼 " .. " Find file", ":Telescope find_files<cr>"),
    button("r", " " .. " Recent files", ":Telescope oldfiles<cr>"),
    button("t", "󱎸 " .. " Find text in files", ":Telescope live_grep<cr>"),
    button("s", " " .. " Sessions", ":lua require('mini.sessions').select()<cr>"),
    button("m", "󰸕 " .. " Bookmarks", "Telescope marks<cr>"),
    button("c", " " .. " EdenVim config", ":lua require('mini.sessions').read('nvim')<cr>"),
    button("d", " " .. " Dotfiles", ":lua require('mini.sessions').read('dotfiles')<cr>"),
    button("q", "󰩈 " .. " Quit", ":qa!<cr>"),
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
    { type = "padding", val = 2 },
    header,
    { type = "padding", val = 2 },
    buttons,
    { type = "padding", val = 2 },
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
