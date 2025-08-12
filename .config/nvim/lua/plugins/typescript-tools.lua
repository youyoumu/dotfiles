return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  lazy = false,
  opts = function(_, opts)
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")
    local is_deno = util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd())

    if is_deno then
      opts.root_dir = lspconfig.util.root_pattern("package.json")
      opts.single_file_support = false
    end

    return opts
  end,
  keys = {
    { "<leader>cM", "<cmd>TSToolsAddMissingImports<CR>", desc = "Add missing imports" },
    { "<leader>cU", "<cmd>TSToolsRemoveUnusedImports<CR>", desc = "Remove unused imports" },
  },
}
