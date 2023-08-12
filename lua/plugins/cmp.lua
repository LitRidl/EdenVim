-- Autocompletion engine that allows specifying "sources" of completion (including cnippets, copilot, etc)
-- A list of sources (Nerd font chars? Tmux panes? All here) https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
-- Note: be careful if setting `select = true` in `Enter` key mapping `["<CR>"] = cmp.mapping.confirm { select = ... }`
-- Some people prefer autoselection of the first suggestion on Enter, but others feel extremely frustrated because
-- they can't use Enter to go to the new line in Insert mode if completions pop up.
-- https://github.com/hrsh7th/nvim-cmp

local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- Source for neovim builtin LSP client
    "hrsh7th/cmp-nvim-lsp",
    -- Source for buffer words
    "hrsh7th/cmp-buffer",
    -- Source for filesystem paths
    "hrsh7th/cmp-path",
    -- Source for vim's cmdline (`/` search based on current buffer + `:` commands)
    "hrsh7th/cmp-cmdline",
    -- Really powerful snippet engine (javadoc, function stubs, etc)
    -- To create your own snippets, visit https://github.com/L3MON4D3/LuaSnip
    "L3MON4D3/LuaSnip",
    -- Luasnip snippets completion source
    "saadparwaiz1/cmp_luasnip",
    -- Source for neovim Lua API
    "hrsh7th/cmp-nvim-lua",
  },
  event = { "InsertEnter", "CmdlineEnter" },
}

function M.config()
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  -- support of importing vs code snippets
  require("luasnip/loaders/from_vscode").lazy_load()

  local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  -- Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/init.lua
  local kind_icons = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  }

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      -- Default documentation popup scrolling keybinds
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      -- Alternative doc scrolling keys (choose if you use <C-b> and <C-f> often)
      -- ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      -- ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      -- Accept currently selected item. If none selected, `select` the first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm { select = false },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = kind_icons[vim_item.kind]
        vim_item.menu = ({
          nvim_lsp = "",
          nvim_lua = "",
          luasnip = "",
          buffer = "",
          path = "",
          emoji = "",
        })[entry.source.name]
        return vim_item
      end,
    },
    -- Add your custom completion sources (like copilot-cmp) here
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sorting = require "cmp.config.default"().sorting,
    experimental = {
      -- If you like gmail-style inline autocompletion, you may try setting this to true
      ghost_text = false,
    },
  }
end

return M
