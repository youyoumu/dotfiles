return {
  "otavioschwanck/arrow.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    -- or if using `mini.icons`
    -- { "echasnovski/mini.icons" },
  },
  -- enabled = false,
  opts = {
    show_icons = true,
    leader_key = "<leader>;", -- Recommended to be a single key
    buffer_leader_key = "<leader>m", -- Per Buffer Mappings
  },
}
