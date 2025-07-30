local disabled_plugins = {
  "neovim/nvim-lspconfig",
  "otavioschwanck/arrow.nvim",
  "LudoPinelli/comment-box.nvim",
  "vyfor/cord.nvim",
  "lewis6991/gitsigns.nvim",
  "m4xshen/hardtime.nvim",
  "mawkler/jsx-element.nvim",
  "youyoumu/pretty-ts-errors.nvim",
  "MeanderingProgrammer/render-markdown.nvim",
  "ibhagwan/smartyank.nvim",
  "Wansmer/treesj",
  "pmizio/typescript-tools.nvim",
  "eero-lehtinen/oklch-color-picker.nvim",
}

return vim.tbl_map(function(repo)
  return { repo, enabled = false }
end, disabled_plugins)
