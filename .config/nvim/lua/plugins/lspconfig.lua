local nvim_lsp = require("lspconfig")
return {
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
        enabled = false,
        root_dir = nvim_lsp.util.root_pattern("package.json"),
      },
      nil_ls = {
        enabled = false,
      },
      nixd = {
        settings = {
          nixd = {
            diagnostic = {
              suppress = {
                -- "sema-unused-def-lambda-noarg-formal",
              },
            },
            formatting = {
              command = { "nixfmt" },
            },
          },
        },
      },
    },
    -- https://github.com/LazyVim/LazyVim/issues/5861#issuecomment-2816353352
    -- today is 31 July 2025
    setup = {
      eslint = function()
        local formatter = LazyVim.lsp.formatter({
          name = "eslint: lsp",
          primary = false,
          priority = 200,
          filter = "eslint",
        })

        -- register the formatter with LazyVim
        LazyVim.format.register(formatter)
      end,
    },

    inlay_hints = { enabled = false },
  },
}
