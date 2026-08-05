local disabled_plugins = {
  "eero-lehtinen/oklch-color-picker.nvim",
}

return vim.tbl_map(function(repo)
  return { repo, enabled = false }
end, disabled_plugins)
