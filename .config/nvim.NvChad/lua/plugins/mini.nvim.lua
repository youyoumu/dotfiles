return {
  {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    config = function()
      require("mini.animate").setup {
        scroll = {
          enable = false,
        },
        resize = {
          enable = false,
        },
      }
    end,
  },
}
