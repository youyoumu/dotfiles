local nvim_lsp = require("lspconfig")
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        ruby_lsp = {
          enabled = true,
          init_options = {
            formatter = "standard",
            linters = { "standard" },
          },
        },
        rubocop = {
          enabled = false,
        },
        denols = {
          filetypes = { "typescript", "typescriptreact" },
          root_dir = function(...)
            return nvim_lsp.util.root_pattern("deno.jsonc", "deno.json")(...)
          end,
          keys = {
            { "gd", vim.lsp.buf.definition },
          },
        },
        vtsls = {
          root_dir = nvim_lsp.util.root_pattern("package.json"),
        },
      },

      inlay_hints = { enabled = false },
    },
  },
}
