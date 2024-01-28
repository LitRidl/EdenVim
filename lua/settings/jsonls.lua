local opts = {
  settings = {
    json = {
      validate = { enable = true },
      schemas = require("schemastore").json.schemas(),
      -- To specify your own schemas, do something like this: 
      -- schemas = require("schemastore").json.schemas {
      --   extra = {
      --     {
      --       description = "My custom JSON schema",
      --       fileMatch = "foo.json",
      --       name = "foo.json",
      --       url = "https://example.com/schema/foo.json",
      --     },
      --     {
      --       description = "My other custom JSON schema",
      --       fileMatch = { "bar.json", ".baar.json" },
      --       name = "bar.json",
      --       url = "https://example.com/schema/bar.json",
      --     },
      --   },
      -- },
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}

return opts
