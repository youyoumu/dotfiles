-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.diagnostic.config({ virtual_text = false })
vim.opt.relativenumber = false
vim.opt.list = false

if vim.g.neovide then
  vim.o.guifont = "Iosevka Term SS14:h11"
  vim.g.neovide_padding_top = 10
  vim.g.neovide_padding_bottom = 10
  vim.g.neovide_padding_right = 10
  vim.g.neovide_padding_left = 10
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
end
