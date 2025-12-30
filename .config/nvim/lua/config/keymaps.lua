-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>dd", '"_d', { desc = "Delete to blackhole register" })
vim.keymap.set("v", "<leader>dd", '"_d', { desc = "Delete to blackhole register" })
vim.keymap.set("n", "<leader>dD", '"_D', { desc = "Delete to blackhole register (to end of line)" })

vim.keymap.set("n", "<leader>k", "<cmd>LazyFormat<CR>", { desc = "Format" })
vim.keymap.set("v", "<leader>k", "<cmd>LazyFormat<CR>", { desc = "Format" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

vim.keymap.set("t", "<C-x>", "<C-\\><C-N>", { desc = "Exit terminal mode" })

vim.keymap.set("i", "<C-o>", "<CR><ESC>kA", { desc = "Insert newline after cursor" })

vim.keymap.set("n", "i", function()
  return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
end, { expr = true, noremap = true, desc = "Insert at beginning of line" })

local hostname = vim.g.current_hostname
pcall(require, "hosts." .. hostname .. ".config.keymaps")
