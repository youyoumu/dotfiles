return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
  keys = {
    { "<leader>cM", "<cmd>TSToolsAddMissingImports<CR>", desc = "Add missing imports" },
    { "<leader>cU", "<cmd>TSToolsRemoveUnusedImports<CR>", desc = "Remove unused imports" },
  },
}
