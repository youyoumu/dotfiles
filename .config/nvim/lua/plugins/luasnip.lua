return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      vim.g.vscode_snippets_path = vim.fn.stdpath("config") .. "/snippets/yym.code-snippets"
      require("luasnip.loaders.from_vscode").load_standalone({
        path = vim.g.vscode_snippets_path,
      })
    end,
  },
}
