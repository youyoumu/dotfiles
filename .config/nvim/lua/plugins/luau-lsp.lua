return {
  "lopi-py/luau-lsp.nvim",
  enabled = false,
  opts = {
    platform = {
      type = "standard",
    },
    sourcemap = {
      enabled = false,
    },
    types = {
      definition_files = {
        -- noctalia = "noctalia.d.luau",
      },
    },
    ignoreGlobs = { "**/*.d.luau" },
  },
}
