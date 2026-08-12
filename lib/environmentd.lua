---@class environmentd
local M = {}

--- Parse a .conf file (environment.d style).
--- Handles comments, blank lines, and backslash continuations.
--- Returns entries in file order, preserving duplicate keys.
---@param content string
---@return { key: string, value: string }[]
function M.parse_conf(content)
	---@type { key: string, value: string }[]
	local result = {}

	-- Join continuation lines
	content = content:gsub("\\\n", "")

	for line in content:gmatch("[^\n]+") do
		-- Skip comments and blank lines
		line = line:match("^%s*(.-)%s*$")
		if line ~= "" and not line:match("^#") then
			local key, value = line:match("^([^=]+)=(.*)$")
			if key then
				key = key:match("^%s*(.-)%s*$")
				value = value:match("^%s*(.-)%s*$")
				result[#result + 1] = { key = key, value = value }
			end
		end
	end

	return result
end

--- Parse a .conf file from disk.
---@param path string
---@return { key: string, value: string }[]
function M.load_conf(path)
	local f = io.open(path, "r")
	if not f then
		return {}
	end
	local content = f:read("*a")
	f:close()
	return M.parse_conf(content)
end

--- Convert conf entries to bash export statements.
---@param conf { key: string, value: string }[]
---@return string
function M.to_env(conf)
	local lines = {}
	for _, entry in ipairs(conf) do
		local value = entry.value:gsub("\\", "\\\\"):gsub('"', '\\"')
		lines[#lines + 1] = string.format('export %s="%s"', entry.key, value)
	end
	return table.concat(lines, "\n")
end

return M