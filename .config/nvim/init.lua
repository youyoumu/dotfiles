local hostname = vim.uv.os_gethostname()
if hostname == "localhost" then
  hostname = os.getenv("HOSTNAME") or "localhost"
end
vim.g.current_hostname = hostname

function _G.log_to_file(msg)
  local log_file = "/tmp/nvim_plugin.log" -- Change this path as needed
  local file = io.open(log_file, "a") -- Open file in append mode
  if file then
    local formatted_msg
    if type(msg) == "table" then
      formatted_msg = vim.inspect(msg)
    else
      formatted_msg = tostring(msg)
    end
    file:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. formatted_msg .. "\n")
    file:close()
  else
    vim.api.nvim_echo({ { "Failed to open log file: " .. log_file, "ErrorMsg" } }, true, {})
  end
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
