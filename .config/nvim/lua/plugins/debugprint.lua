local js_like = {
  left = 'console.log("',
  right = '")',
  mid_var = '", ',
  right_var = ")",
}

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
        variable_below = "<leader>dv",
        plain_below = "<leader>dr",
      },
    },
    move_to_debugline = true,
    display_location = false,
    print_tag = "DEBUG",
  },
}
