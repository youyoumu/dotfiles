-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.diagnostic.config({ virtual_text = false })
vim.opt.relativenumber = true
vim.opt.list = false

vim.filetype.add({
  extension = {
    hbs = "html",
    svg = "xml",
  },
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

if vim.g.neovide then
  vim.o.guifont = "IosevkaTerm Nerd Font:h11"
  vim.g.neovide_padding_top = 10
  vim.g.neovide_padding_bottom = 10
  vim.g.neovide_padding_right = 10
  vim.g.neovide_padding_left = 10
  vim.g.neovide_cursor_vfx_mode = "sonicboom"

  vim.g.terminal_color_0 = "#45475a"
  vim.g.terminal_color_1 = "#f38ba8"
  vim.g.terminal_color_2 = "#a6e3a1"
  vim.g.terminal_color_3 = "#f9e2af"
  vim.g.terminal_color_4 = "#89b4fa"
  vim.g.terminal_color_5 = "#f5c2e7"
  vim.g.terminal_color_6 = "#94e2d5"
  vim.g.terminal_color_7 = "#bac2de"
  vim.g.terminal_color_8 = "#585b70"
  vim.g.terminal_color_9 = "#f38ba8"
  vim.g.terminal_color_10 = "#a6e3a1"
  vim.g.terminal_color_11 = "#f9e2af"
  vim.g.terminal_color_12 = "#89b4fa"
  vim.g.terminal_color_13 = "#f5c2e7"
  vim.g.terminal_color_14 = "#94e2d5"
  vim.g.terminal_color_15 = "#a6adc8"
end

vim.opt.spelllang = { "en", "en_us", "en_gb", "id" }
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/custom.utf-8.add"
-- Ensure that the binary spl file is up-to-date with the source add file
local function update_spell()
  local config_path = vim.fn.stdpath("config") .. "/spell"

  -- List of base names (without encoding extension)
  local langs = { "custom", "en", "id" }

  for _, lang in ipairs(langs) do
    local add_file = string.format("%s/%s.utf-8.add", config_path, lang)
    local spl_file = string.format("%s/%s.utf-8.add.spl", config_path, lang)

    if vim.fn.filereadable(add_file) == 1 then
      local add_mtime = vim.fn.getftime(add_file)
      local spl_mtime = vim.fn.getftime(spl_file) -- this is -1 if file doesn't exist

      -- Run mkspell! only if .add is newer than .add.spl or .add.spl doesn't exist
      if add_mtime > spl_mtime or spl_mtime == -1 then
        vim.cmd(string.format("silent! mkspell! %s %s", spl_file, add_file))
      end
    end
  end
end
update_spell()

local hostname = vim.g.current_hostname
pcall(require, "hosts." .. hostname .. ".config.options")
