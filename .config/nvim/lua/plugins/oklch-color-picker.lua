return {
  "eero-lehtinen/oklch-color-picker.nvim",
  event = "VeryLazy",
  version = "*",
  ---@type oklch.Opts
  opts = {},
  keys = {
    -- One handed keymap recommended, you will be using the mouse
    {
      "<leader>cp",
      function()
        require("oklch-color-picker").pick_under_cursor()
      end,
      desc = "Color pick under cursor",
    },
  },
}
