return {
  "tamton-aquib/duck.nvim",
  config = function()
    vim.keymap.set("n", "<leader>dh", function()
      require("duck").hatch()
    end, { desc = "Hatch a duck" })
    vim.keymap.set("n", "<leader>dk", function()
      require("duck").cook()
    end, { desc = "Cook a duck" })
    vim.keymap.set("n", "<leader>da", function()
      require("duck").cook_all()
    end, { desc = "Cook all ducks" })
  end,
}
