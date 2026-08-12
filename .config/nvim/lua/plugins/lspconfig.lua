local toolchain = require("config.toolchain")

---@class PluginLspOpts
local _opts = {
  servers = {
    vtsls = {
      enabled = false,
    },
    tailwindcss = {
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
            },
          },
        },
      },
    },
    oxlint = {
      settings = {
        typeAware = true,
      },
    },
  },
}

return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = function(_, opts)
    opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, _opts.servers)
    opts.inlay_hints = { enabled = false }
    toolchain.disable_mason_install(opts.servers)
    return opts
  end,
}
