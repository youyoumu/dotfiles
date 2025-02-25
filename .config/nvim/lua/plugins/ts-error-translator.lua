return {
  {
    "dmmulroy/ts-error-translator.nvim",
    enabled = false,
    config = function()
      require("ts-error-translator").setup()
    end,
  },
}
