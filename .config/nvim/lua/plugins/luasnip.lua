return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      vim.g.vscode_snippets_path = vim.fn.stdpath("config") .. "/snippets/yym.code-snippets"
      require("luasnip.loaders.from_vscode").load_standalone({
        path = vim.g.vscode_snippets_path,
      })
    end,
  },
}
