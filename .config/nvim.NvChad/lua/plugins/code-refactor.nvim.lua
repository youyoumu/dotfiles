return {
  {
    "jdrupal-dev/code-refactor.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>cr", "<cmd>CodeActions all<CR>", desc = "Show code-refactor.nvim (not LSP code actions)" },
    },
    config = function()
      require("code-refactor").setup {
        -- Configuration here, or leave empty to use defaults.
      }
    end,
  },
}
