-- Allows inlay hinting, AST preview, source/header switch, type hierarchy, etc
-- Note for C/C++: for complex projects like Linux kernel, clang relies on "JSON compilation database"
-- Use https://github.com/rizsotto/Bear to "wrap" build process and autogenerate compile_commands.json
-- https://github.com/p00f/clangd_extensions.nvim

local M = {
  "p00f/clangd_extensions.nvim",
  enabled = true,
  event = {
    "BufRead *.c,*cpp,*cc,*cxx,*h,*hh,*hpp,*hxx",
    "BufNewFile *.c,*cpp,*cc,*cxx,*h,*hh,*hpp,*hxx",
  },
  dependencies = { "neovim/nvim-lspconfig" },
  opts = {
    server = {
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu", -- set to `never` if causing problems
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
        "--cross-file-rename",
        "--suggest-missing-includes",
        -- "-j=8", -- number of workers
        -- "--query-driver=/usr/bin/g++", -- see `clangd --help`. os.getenv "CC" is a useful option for value here
        -- "--offset-encoding=utf-16", -- normally, it is set by opts.server.capabilities
      },
      -- Helping clangd_extensions find the proper project root (source: LazyVim)
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
          "Makefile",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "meson.build",
          "meson_options.txt",
          "build.ninja"
        )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
          "lspconfig.util"
        ).find_git_ancestor(fname)
      end,
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
      filetypes = { "c", "cc", "cpp", "objc", "objcpp", "cuda", "proto" },
      single_file_support = true,
    },
    extensions = {
      -- Default options
      inlay_hints = {
        inline = vim.fn.has "nvim-0.10" == 1,
        -- Options other than `highlight' and `priority' only work
        -- if `inline' is disabled
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refresh of the inlay hints.
        -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
        -- not that this may cause  higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = { "CursorHold" },
        -- whether to show parameter hints with the inlay hints or not
        show_parameter_hints = true,
        -- prefix for parameter hints
        parameter_hints_prefix = "<- ",
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 7,
        -- The color of the hints
        highlight = "Comment",
        -- The highlight group priority for extmark
        priority = 100,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
      memory_usage = {
        border = "single",
      },
      symbol_info = {
        border = "single",
      },
    },
  },
}

function M.config(_, opts)
  require("clangd_extensions").setup(opts)
  -- Improve ranking of autocompletion with clangd_extensions scoring model
  vim.api.nvim_create_autocmd("Filetype", {
    desc = "Setup clangd_extensions comparator scores for nvim-cmp",
    pattern = "c,cc,cpp,objc,objcpp,cuda,proto,h,hh,hpp,hxx",
    callback = function()
      local cmp = require "cmp"
      cmp.setup.buffer {
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require "clangd_extensions.cmp_scores",
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      }
    end,
  })

  -- Buffer-local ClangdSwitchSourceHeader keybind
  vim.api.nvim_create_autocmd("Filetype", {
    desc = "Switch Source/Header (C/C++) with clangd_extensions",
    pattern = "c,cc,cpp,objc,objcpp,h,hh,hpp,hxx",
    callback = function()
      vim.keymap.set("n", "<leader>T", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Toggle Source/Header file (C/C++)", buffer = true })
    end,
  })
end

return M
