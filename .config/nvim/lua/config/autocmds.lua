-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- systemd-lsp
-- Automatically set filetype and start LSP for specific systemd unit file patterns
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.service", "*.mount", "*.device", "*.nspawn", "*.target", "*.timer" },
  callback = function()
    vim.bo.filetype = "systemd"
    vim.lsp.start({
      name = "systemd_ls",
      cmd = { "systemd-lsp" }, -- Update this path to your systemd-lsp binary
      root_dir = vim.fn.getcwd(),
    })
  end,
})

local hostname = vim.g.current_hostname
pcall(require, "hosts." .. hostname .. ".config.autocmds")
