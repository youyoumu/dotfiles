return {
  { "nvzone/volt", lazy = true },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
    keys = {
      { "<leader>ms", ":Shades<CR>", desc = "Minty toggle Shades" },
      { "<leader>mh", ":Huefy<CR>", desc = "Minti toggle Huefy" },
    },
  },
}
