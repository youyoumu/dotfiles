local M = {}

local exclude_file = vim.fn.stdpath("config") .. "/lua/config/excluded-mason-packages.json"
local exclude_json = assert(vim.fn.readfile(exclude_file), "Unable to read " .. exclude_file)
M.exclude = vim.json.decode(table.concat(exclude_json, "\n"))

---@param name string
---@return boolean
function M.is_excluded(name)
  for _, package in ipairs(M.exclude) do
    if package[1] == name or package[3] == name then
      return true
    end
  end
  return false
end

---@param list string[]
---@return string[]
function M.filter_tools(list)
  return vim.tbl_filter(function(tool)
    return not M.is_excluded(tool)
  end, list)
end

---Prevent mason-lspconfig from installing servers provided by nix.
---@param servers table<string, table>
function M.disable_mason_install(servers)
  for name, conf in pairs(servers or {}) do
    if (name ~= "*") and M.is_excluded(name) and type(conf) == "table" and conf.enabled ~= false then
      conf.mason = false
    end
  end
end

return M
