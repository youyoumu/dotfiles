return {
  "folke/noice.nvim",
  opts = {
    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
    },
  },
}
