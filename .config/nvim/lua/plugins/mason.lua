return {
  "mason-org/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "xmlformatter",
      "ktfmt",
      "oxfmt",
      "nixfmt",
      "statix",
    })
  end,
}
