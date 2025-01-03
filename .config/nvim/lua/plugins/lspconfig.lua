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
      },
      inlay_hints = { enabled = false },
    },
  },
}
