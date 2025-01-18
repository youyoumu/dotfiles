local fzf_lua = require("fzf-lua")

-- Define a command to run zoxide query
vim.api.nvim_create_user_command("ZoxideFzf", function()
  fzf_lua.fzf_exec(
    "zoxide query -l", -- Command to fetch zoxide entries
    {
      prompt = "📁 󰜴 ",
      preview = "eza --color=always --icons=always -a -T -L 1 {}",
      actions = {
        ["default"] = function(selected)
          if selected[1] then
            vim.cmd("cd " .. selected[1])
            print("Changed directory to: " .. selected[1])
          end
        end,
      },
    }
  )
end, {})

return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        preview = {
          delay = 200,
        },
      },
    },
  },
}
