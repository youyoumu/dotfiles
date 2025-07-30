return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  opts = {
    use_default_keymaps = false,
  },
  -- stylua: ignore
  keys = {
    { "<leader>tm", function() require("treesj").toggle() end, desc = "Toggle treesj" },
    { "<leader>ts", function() require("treesj").split() end, desc = "Split treesj" },
    { "<leader>tj", function() require("treesj").join() end, desc = "Join treesj" },
  },
}
