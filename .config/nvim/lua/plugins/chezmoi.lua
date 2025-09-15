local home = os.getenv("HOME") or os.getenv("USERPROFILE")
if not home then
  return
end

local chezmoi_path = home .. "/dotfiles/chezmoi/*"

return {
  {
    "xvzc/chezmoi.nvim",
    init = function()
      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { chezmoi_path },
        callback = function()
          vim.schedule(require("chezmoi.commands.__edit").watch)
        end,
      })
    end,
  },
  {
    -- highlighting for chezmoi files template files
    "alker0/chezmoi.vim",
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = 1
      vim.g["chezmoi#source_dir_path"] = home .. "/.local/share/chezmoi"
    end,
  },
}
