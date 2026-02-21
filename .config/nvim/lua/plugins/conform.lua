return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ruby = { "standardrb" },
      javascript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
      typescript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
      html = { "biome-check", "prettierd", "prettier", stop_after_first = true },
      css = { "biome-check", "prettierd", "prettier", stop_after_first = true },
      -- kdl = { "kdlfmt" },
      just = { "just" },
      xml = { "xmlformatter" },
    },
  },
}
