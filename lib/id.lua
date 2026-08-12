---@class id
local M = {}

local hex = "0123456789abcdef"

--- Generate a random hex string.
---@param len number Length of the output string.
---@return string
local function random_hex(len)
	local bytes = {}
	for i = 1, len do
		local idx = math.random(1, #hex)
		bytes[i] = hex:sub(idx, idx)
	end
	return table.concat(bytes)
end

--- Generate a nanoid (random hex string).
---@param len? number Length of the id (default 21).
---@param seed? number Optional seed for deterministic output.
---@return string
function M.nanoid(len, seed)
	if seed then
		math.randomseed(seed)
	end
	return random_hex(len or 21)
end

--- Generate a UUID v4.
---@return string
function M.uuid()
	local r = random_hex
	return table.concat({
		r(8),
		"-",
		r(4),
		"-",
		"4",
		r(3),
		"-",
		r(4),
		"-",
		r(12),
	})
end

return M
