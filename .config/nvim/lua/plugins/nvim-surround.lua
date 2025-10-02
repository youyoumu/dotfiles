return {
  "kylechui/nvim-surround",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
      keymaps = {
        visual = "m",
        visual_line = "M",
      },
    })
  end,
}
