local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
  commit = "dafa11a6218c2296df044e00f88d9187222ba6b0",
}

function M.config()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  dashboard.section.header.val = {
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
  }

  dashboard.section.buttons.val = {
    dashboard.button("f", "󰱼 " .. " Find file", ":Telescope find_files <cr>"),
    dashboard.button("e", "󰝒 " .. " New file", ":ene <BAR> startinsert <cr>"),
    dashboard.button("s", "󰸕 " .. " Sessions", ":Telescope possession list<cr>"),
    dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles<cr>"),
    dashboard.button("t", "󱎸 " .. " Find text", ":Telescope live_grep<cr>"),
    dashboard.button("c", " " .. " EdenVim config", ":SLoad edenvim-config<cr>"),
    dashboard.button("d", " " .. " Dotfiles", ":SLoad dotfiles<cr>"),
    dashboard.button("q", "󰩈 " .. " Quit", ":qa<cr>"),
  }
  local function footer()
    return "github.com/LitRidl"
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Type"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Keyword"

  dashboard.opts.opts.noautocmd = true
  alpha.setup(dashboard.opts)
end

return M
