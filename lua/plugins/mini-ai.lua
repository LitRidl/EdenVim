-- Enhances builtin textobjects (like a(, a), a', and more) and creates new ones (like a*, a<Space>, af, a?, and more)
-- Note: since text objects often end up a powerful productivity booster, I recommend trying it out thoroughly
-- https://github.com/echasnovski/mini.ai

local M = {
  "echasnovski/mini.ai",
  enabled = true,
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },

  opts = function()
    local ai = require "mini.ai"
    return {
      n_lines = 100,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
      },
    }
  end,
}

function M.config(_, opts)
  require("mini.ai").setup(opts)

  -- Optional: registering text objects in which-key (Source: LazyVim)
  local objects = {
    { " ", desc = "whitespace" },
    { '"', desc = '" string' },
    { "'", desc = "' string" },
    { "(", desc = "() block" },
    { ")", desc = "() block with ws" },
    { "<", desc = "<> block" },
    { ">", desc = "<> block with ws" },
    { "?", desc = "user prompt" },
    { "U", desc = "use/call without dot" },
    { "[", desc = "[] block" },
    { "]", desc = "[] block with ws" },
    { "_", desc = "underscore" },
    { "`", desc = "` string" },
    { "a", desc = "argument" },
    { "b", desc = ")]} block" },
    { "c", desc = "class" },
    { "d", desc = "digit(s)" },
    { "e", desc = "CamelCase / snake_case" },
    { "f", desc = "function" },
    { "g", desc = "entire file" },
    { "i", desc = "indent" },
    { "o", desc = "block, conditional, loop" },
    { "q", desc = "quote `\"'" },
    { "t", desc = "tag" },
    { "u", desc = "use/call" },
    { "{", desc = "{} block" },
    { "}", desc = "{} with ws" },
  }
  local ret = { mode = { "o", "x" } }
  local mappings = vim.tbl_extend("force", {}, {
    around = "a",
    inside = "i",
    around_next = "an",
    inside_next = "in",
    around_last = "al",
    inside_last = "il",
  }, opts.mappings or {})
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    name = name:gsub("^around_", ""):gsub("^inside_", "")
    ret[#ret + 1] = { prefix, group = name }
    for _, obj in ipairs(objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == "i" then
        desc = desc:gsub(" with ws", "")
      end
      ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
    end
  end

  require("which-key").add(ret, { notify = false })
end

return M
