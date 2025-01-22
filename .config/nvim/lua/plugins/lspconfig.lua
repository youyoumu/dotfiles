local nvim_lsp = require("lspconfig")
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        ruby_lsp = {
          enabled = true,
          init_options = {
            formatter = "standard",
            linters = { "standard" },
          },
        },
        rubocop = {
          enabled = false,
        },
        denols = {
          filetypes = { "typescript", "typescriptreact" },
          root_dir = function(...)
            return nvim_lsp.util.root_pattern("deno.jsonc", "deno.json")(...)
          end,
          keys = {
            { "gd", vim.lsp.buf.definition },
          },
        },
        vtsls = {
          root_dir = nvim_lsp.util.root_pattern("package.json"),
        },
      },
      setup = {
        -- auto fix suddenlt stopped workin so i added this, check the issue later (today is 22 jan 2025)
        -- https://github.com/LazyVim/LazyVim/discussions/402
        eslint = function()
          -- automatically fix linting errors on save (but otherwise do not format the document)
          vim.cmd([[
          autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll
        ]])
        end,
      },

      inlay_hints = { enabled = false },
    },
  },
}
