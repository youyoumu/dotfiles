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

vim.keymap.set("i", "<C-o>", "<CR><ESC>kA", { desc = "Insert newline after cursor" })

-- Create a function to add multiple abbreviations with custom triggers
local function add_abbreviations_with_triggers(abbreviations)
  for trigger, replacement in pairs(abbreviations) do
    vim.keymap.set("i", trigger, replacement, { noremap = true })
  end
end

-- Define your mappings with triggers
local mappings = {
  [",r"] = "return",
  [",f"] = "filter",
  [",c"] = "const",
  -- Add more as needed
}

add_abbreviations_with_triggers(mappings)

-- Create a function to add multiple abbreviations
local function add_abbreviations(abbreviations)
  for wrong, right in pairs(abbreviations) do
    vim.cmd(string.format("iabbrev %s %s", wrong, right))
  end
end

-- Define your common typos
local typos = {
  fitler = "filter",
  reutrn = "return",
  fitlered = "filtered",
  -- Add more as needed
}

add_abbreviations(typos)

local hostname = vim.g.current_hostname
pcall(require, "hosts." .. hostname .. ".config.keymaps")
