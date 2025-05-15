local js_like = {
  left = 'console.log("',
  right = '")',
  mid_var = '", ',
  right_var = ")",
}

vim.api.nvim_set_hl(0, "DebugPrintLine", { bg = "#313244" })

return {
  "andrewferrier/debugprint.nvim",
  opts = {
    filetypes = {
      ["javascript"] = js_like,
      ["javascriptreact"] = js_like,
      ["typescript"] = js_like,
      ["typescriptreact"] = js_like,
    },
    keymaps = {
      normal = {
        variable_below = "<leader>v",
      },
    },
    display_location = false,
    print_tag = "DEBUG",
  },
}
