require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Exit insert mode and save file" })
map("n", "]c", ":cnext<CR>", { silent = true, desc = "Quick fix next" })
map("n", "[c", ":cprev<CR>", { silent = true, desc = "Quick fix previous" })

map("n", "<leader>cc", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

map("n", "<leader>fc", "<cmd> Telescope commands <CR>", { desc = "List commands" })

map("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
map("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
map("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
map("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})
