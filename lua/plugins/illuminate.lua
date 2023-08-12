-- Highlights occurencies of the word under the cursor. It also maps <a-n> and <a-p>
-- to move between references and <a-i> as a textobject for the reference illuminated under the cursor
-- https://github.com/RRethy/vim-illuminate

local M = {
  "RRethy/vim-illuminate",
  enabled = true,
  event = { "BufReadPost", "BufNewFile" },

  opts = {
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 200,
    large_file_cutoff = 3000,
    -- if overrides = nil, the highligthing is disabled
    large_file_overrides = nil,
    filetypes_denylist = {
      "dirvish",
      "fugitive",
      "alpha",
      "NvimTree",
      "packer",
      "neogitstatus",
      "Trouble",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "TelescopePrompt",
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
    min_count_to_highlight = 1,
  },
}

function M.config(_, opts)
  require("illuminate").configure(opts)
end

return M
