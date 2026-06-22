-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Prevent LSP diagnostics from popping up for files with environment variables
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = vim.api.nvim_create_augroup("LspHacks", { clear = true }),
  pattern = ".env*",
  callback = function(e)
    vim.diagnostic.enable(false, { bufnr = e.buf })
  end,
})

local hostname = vim.g.current_hostname
pcall(require, "hosts." .. hostname .. ".config.autocmds")
