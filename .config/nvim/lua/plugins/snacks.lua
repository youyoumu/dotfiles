vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#f9e2af" })

return {
  {
    "snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
      picker = {
        explorer = { replace_netrw = true },
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            layout = {
              layout = {
                width = 50,
              },
              preview = { main = true, enabled = false },
              auto_hide = { "input" },
            },
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
            -- corner_top = "╭",
            -- corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = "─",
          },
        },
        animate = {
          easing = "outExpo",
          duration = {
            step = 100, -- ms per step
            total = 500, -- maximum duration
          },
        },
      },
      dashboard = {
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { pane = 1, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { section = "keys", gap = 1, padding = 1, pane = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
