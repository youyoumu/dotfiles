return {
  "folke/snacks.nvim",
  init = function()
    vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#f9e2af" })
  end,
  opts = {
    picker = {
      sources = {
        projects = {
          dev = { "~/repos" },
        },
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 9999,
        },
      },
    },
    scroll = { enabled = false },
    indent = {
      indent = {
        char = "┊",
      },
      scope = {
        char = "╎",
      },
      chunk = {
        enabled = true,
        char = {
          corner_top = "┌",
          corner_bottom = "└",
          horizontal = "─",
          vertical = "│",
          arrow = "─",
        },
      },
    },
  },
}
