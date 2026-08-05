vim.keymap.set({ "n", "x", "o" }, "<A-o>", function()
  require("flash").treesitter({
    actions = {
      ["<A-o>"] = "next",
      ["<A-i>"] = "prev",
    },
  })
end, { desc = "Treesitter incremental selection" })
