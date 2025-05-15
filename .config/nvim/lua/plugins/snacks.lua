vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#f9e2af" })

return {
  "folke/snacks.nvim",
  -- url = "https://github.com/youyoumu/snacks.nvim.git",
  -- branch = "add-modified-icon-to-picker",
  opts = {
    explorer = {
      replace_netrw = true,
    },
    picker = {
      explorer = {
        replace_netrw = true,
      },
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
          actions = {
            safe_delete = function(picker)
              local selected = picker:selected({ fallback = true })
              local has_root = vim.iter(selected):any(function(s)
                return not s.parent
              end)
              if has_root then
                vim.print("No, bad boy!")
                return
              end
              picker:action("explorer_del")
            end,
          },
          win = {
            list = {
              keys = {
                ["d"] = "safe_delete",
              },
            },
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
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        },
      },
      sections = {
        { section = "header" },
        { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1, limit = 10 },
        {
          pane = 1,
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 1,
          limit = 3,
        },
        { section = "keys", gap = 1, padding = 1, pane = 1 },
        { section = "startup" },
      },
    },
  },
}
