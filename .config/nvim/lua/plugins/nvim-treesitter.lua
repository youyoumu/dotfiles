return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "svelte",
        "typescript",
        "javascript",
        "tsx",
      },
    },
  },
}
