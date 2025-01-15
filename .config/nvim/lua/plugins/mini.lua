return {
  {
    "echasnovski/mini.nvim",
    event = "BufReadPost",
    version = false,
    config = function()
      local map = require("mini.map")
      map.setup()
      map.open()

      vim.keymap.set("n", "<Leader>mt", MiniMap.toggle, { desc = "Toggle MiniMap" })
    end,
  },
}
