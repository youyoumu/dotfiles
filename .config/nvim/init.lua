local hostname = vim.uv.os_gethostname()
if hostname == "localhost" then
  hostname = os.getenv("HOSTNAME") or "localhost"
end
vim.g.current_hostname = hostname

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
