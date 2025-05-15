return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  opts = {
    window = {
      width = 50,
      mappings = {
        ["e"] = function()
          vim.api.nvim_exec2("Neotree focus filesystem left", { output = false })
        end,
        ["b"] = function()
          vim.api.nvim_exec2("Neotree focus buffers left", { output = false })
        end,
        ["g"] = function()
          vim.api.nvim_exec2("Neotree focus git_status left", { output = false })
        end,
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        -- hide_dotfiles = false,
        -- hide_gitignored = false,
        never_show = { ".git" },
      },
    },
    default_component_configs = {
      icon = {},
      indent = {},
    },
  },
}
