require "nvchad.options"

require("lspconfig").eslint.setup {
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}

vim.g.coc_global_extensions = { "coc-markdownlint" }
vim.opt.scrolloff = 8
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- vim.opt.relativenumber = true
