return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>si",
      function()
        require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
      end,
      mode = { "v" },
      desc = "grug-far: Search within range",
    },
    {
      "<leader>sf",
      function()
        require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = { "v" },
      desc = "grug-far: Search within file (visual)",
    },
    {
      "<leader>sf",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = { "n" },
      desc = "grug-far: Search within file",
    },
  },
}
