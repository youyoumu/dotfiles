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

vim.diagnostic.config { virtual_text = false }
vim.g.gitblame_set_extmark_options = {
  priority = 1000,
}
vim.g.gitblame_delay = 5000
vim.g.gitblame_message_template = "󰘬 <author> • <date> • <summary>"
vim.g.gitblame_message_when_not_committed = "󰘬 ------ "

vim.g.coc_global_extensions = { "coc-markdownlint" }
vim.opt.scrolloff = 8
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- vim.opt.relativenumber = true
