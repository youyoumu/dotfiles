local disabled_plugins = {}

return vim.tbl_map(function(repo)
  return { repo, enabled = false }
end, disabled_plugins)
