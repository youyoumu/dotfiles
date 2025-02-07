return {
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    opts = {}, -- calls require('cord').setup()
    event = "VeryLazy",
  },
}
