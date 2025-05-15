return {
  { "nvzone/volt", enabled = false, lazy = true },

  {
    "nvzone/minty",
    enabled = false,
    cmd = { "Shades", "Huefy" },
    keys = {
      { "<leader>ms", ":Shades<CR>", desc = "Minty toggle Shades" },
      { "<leader>mh", ":Huefy<CR>", desc = "Minti toggle Huefy" },
    },
  },
}
