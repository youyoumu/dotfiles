-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("t", "<C-x>", "<C-\\><C-N>", { desc = "Exit terminal mode" })
vim.keymap.set("i", "<C-o>", "<CR><ESC>kA", { desc = "Insert newline after cursor" })

local hostname = vim.g.current_hostname
pcall(require, "hosts." .. hostname .. ".config.keymaps")
