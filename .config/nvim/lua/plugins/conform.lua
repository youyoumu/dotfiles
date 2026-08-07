return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ruby = { "standardrb" },
      javascript = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },
      typescript = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },
      html = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },
      vue = { "oxfmt" },
      svelte = { "oxfmt" },
      astro = { "oxfmt" },
      css = { "oxfmt", "biome-check", "prettierd", "prettier", stop_after_first = true },
      scss = { "oxfmt" },
      less = { "oxfmt" },
      json = { "oxfmt" },
      jsonc = { "oxfmt" },
      json5 = { "oxfmt" },
      markdown = { "oxfmt" },
      ["markdown.mdx"] = { "oxfmt" },
      graphql = { "oxfmt" },
      handlebars = { "oxfmt" },

      -- kdl = { "kdlfmt" },
      just = { "just" },
      xml = { "xmlformatter" },

      luau = { "stylua" },
    },
  },
}
