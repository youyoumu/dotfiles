return {
  "folke/flash.nvim",
  opts = {
    search = {
      multi_window = false,
    },
    modes = {
      treesitter = {
        -- remove d, c for motions
        labels = "abefghijklmnoqrstuvwxz",
        label = { before = false, after = false },
      },
    },
  },
}
