return {
  "youyoumu/pretty-ts-errors.nvim",
  name = "pretty-ts-errors.nvim",
  -- dir = "~/repos/pretty-ts-errors.nvim-vaspadi/",
  dev = false,
  opts = {
    -- your configuration options

    auto_open = false,
  },
  keys = {
    {
      "<leader>tt",
      function()
        require("pretty-ts-errors").show_formatted_error()
      end,
      desc = "Show TS error",
    },
    {
      "<leader>tE",
      function()
        require("pretty-ts-errors").open_all_errors()
      end,
      desc = "Show all TS errors",
    },
    {
      "<leader>tT",
      function()
        require("pretty-ts-errors").toggle_auto_open()
      end,
      desc = "Toggle TS error auto-display",
    },
  },
}
