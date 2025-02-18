return {
  {
    "LeonHeidelbach/trailblazer.nvim",
    enabled = false,
    config = function()
      require("trailblazer").setup({
        force_mappings = { -- rename this to "force_mappings" to completely override default mappings and not merge with them
          nv = { -- Mode union: normal & visual mode. Can be extended by adding i, x, ...
            motions = {
              new_trail_mark = "<A-m>",
              track_back = "<A-b>",
              peek_move_next_down = "<A-J>",
              peek_move_previous_up = "<A-K>",
              move_to_nearest = "<A-c>",
              toggle_trail_mark_list = "<A-w>",
            },
            actions = {
              delete_all_trail_marks = "<A-L>",
              paste_at_last_trail_mark = "<A-p>",
              paste_at_all_trail_marks = "<A-P>",
              set_trail_mark_select_mode = "<A-t>",
              switch_to_next_trail_mark_stack = "<A-.>",
              switch_to_previous_trail_mark_stack = "<A-,>",
              set_trail_mark_stack_sort_mode = "<A-s>",
            },
          },
          -- You can also add/move any motion or action to mode specific mappings i.e.:
          -- i = {
          --     motions = {
          --         new_trail_mark = '<C-l>',
          --         ...
          --     },
          --     ...
          -- },
        },
        trail_options = {
          newest_mark_symbol = "", -- disable this mark symbol by setting its value to ""
          cursor_mark_symbol = "", -- disable this mark symbol by setting its value to ""
          next_mark_symbol = "", -- disable this mark symbol by setting its value to ""
          previous_mark_symbol = "", -- disable this mark symbol by setting its value to ""
        },
      })
    end,
  },
}
