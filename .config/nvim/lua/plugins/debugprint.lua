local js_like = {
  left = 'console.info("',
  right = '")',
  mid_var = '", ',
  right_var = ")",
}
return {
  {
    "andrewferrier/debugprint.nvim",
    opts = {
      filetypes = {
        ["javascript"] = js_like,
        ["javascriptreact"] = js_like,
        ["typescript"] = js_like,
        ["typescriptreact"] = js_like,
      },
    },
  },
}
