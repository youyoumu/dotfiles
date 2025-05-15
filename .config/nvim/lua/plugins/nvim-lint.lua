return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", vim.fn.expand("~/.config/nvim/lua/plugins/.markdownlint-cli2.yaml"), "--" },
      },
    },
  },
}
