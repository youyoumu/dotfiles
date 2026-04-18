return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    vim.g.nvim_surround_no_visual_mappings = true
    vim.keymap.set("x", "m", "<Plug>(nvim-surround-visual)", {
      desc = "Add a surrounding pair around a visual selection",
    })
    vim.keymap.set("x", "M", "<Plug>(nvim-surround-visual-line)", {
      desc = "Add a surrounding pair around a visual selection, on new lines",
    })
    require("nvim-surround").setup({})
  end,
}