return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "┌",
            left_bottom = "└",
            right_arrow = "─",
          },
          style = "#ebeb34",
        },
        indent = {
          enable = true,
          chars = {
            "│",
            "¦",
            "┊",
          },
        },
      })
    end,
  },
}
