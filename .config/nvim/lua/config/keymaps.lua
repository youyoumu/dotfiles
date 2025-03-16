-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
vim.keymap.set("n", "go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

vim.keymap.set("n", "<leader>dd", '"_d', { desc = "Delete to blackhole register" })
vim.keymap.set("v", "<leader>dd", '"_d', { desc = "Delete to blackhole register" })
vim.keymap.set("n", "<leader>dD", '"_D', { desc = "Delete to blackhole register (to end of line)" })

vim.keymap.set("n", "<leader>k", "<cmd>Format<CR>", { desc = "Format code" })
vim.keymap.set("v", "<leader>k", "<cmd>Format<CR>", { desc = "Format code" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("t", "<C-x>", "<C-\\><C-N>")

vim.keymap.set("n", "<leader>tm", require("treesj").toggle, { desc = "Toggle treesj" })
vim.keymap.set("n", "<leader>ts", require("treesj").split, { desc = "Split treesj" })
vim.keymap.set("n", "<leader>tj", require("treesj").join, { desc = "Join treesj" })

vim.keymap.set("i", "<C-o>", "<CR><ESC>kA", { desc = "Insert newline after cursor" })

vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })

-- Only add the two specified commands with descriptions
vim.keymap.set("n", "<leader>cM", "<cmd>TSToolsAddMissingImports<CR>", { desc = "Add missing imports" })
vim.keymap.set("n", "<leader>cU", "<cmd>TSToolsRemoveUnusedImports<CR>", { desc = "Remove unused imports" })

vim.keymap.set("n", "<leader>e", function()
  local explorer_pickers = Snacks.picker.get({ source = "explorer" })
  for _, v in pairs(explorer_pickers) do
    if v:is_focused() then
      v:close()
    else
      v:focus()
    end
  end
  if #explorer_pickers == 0 then
    Snacks.picker.explorer()
  end
end, { desc = "Open, Focus, Close Snacks picker" })

vim.keymap.set({ "v" }, "<leader>si", function()
  require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
end, { desc = "grug-far: Search within range" })

vim.keymap.set({ "v" }, "<leader>sf", function()
  require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "grug-far: Search within file" })

vim.keymap.set({ "n" }, "<leader>sf", function()
  require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "grug-far: Search within file" })
