return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-j>"] = {
        function(cmp)
          cmp.show({ providers = { "snippets" } })
        end,
      },
    },
  },
}
