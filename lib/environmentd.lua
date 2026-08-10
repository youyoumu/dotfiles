---@class environmentd
local M = {}

--- Parse a .conf file (environment.d style).
--- Handles comments, blank lines, and backslash continuations.
---@param content string
---@return table<string, string>
function M.parse_conf(content)
	---@type table<string, string>
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
			result[key] = value
			end
		end
	end

	return result
end

--- Parse a .conf file from disk.
---@param path string
---@return table<string, string>
function M.load_conf(path)
	local f = io.open(path, "r")
	if not f then
		return {}
	end
	local content = f:read("*a")
	f:close()
	return M.parse_conf(content)
end

--- Convert a conf table to bash export statements.
---@param conf table<string, string>
---@return string
function M.to_env(conf)
	local lines = {}
	for key, value in pairs(conf) do
		value = value:gsub('\\', '\\\\'):gsub('"', '\\"')
		lines[#lines + 1] = string.format('export %s="%s"', key, value)
	end
	return table.concat(lines, "\n")
end

return M
