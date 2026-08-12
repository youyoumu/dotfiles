return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local toolchain = require("config.toolchain")
      local ensure_installed = opts.ensure_installed or {}
      opts.ensure_installed = toolchain.filter_tools(ensure_installed)
    end,
  },
}
