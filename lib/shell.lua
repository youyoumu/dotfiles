---@class shell
local M = {}

--- Run a shell command and return its output.
---@param ... string Command and arguments to execute.
---@return string output The stdout of the command.
function M.run(...)
	local cmd = table.concat({ ... }, " ")
	local handle = io.popen(cmd)
	if not handle then
		error("failed to run: " .. cmd)
	end
	local result = handle:read("*a")
	handle:close()
	return result
end

--- Sleep for a number of seconds.
---@param seconds number
function M.sleep(seconds)
	os.execute(string.format("sleep %s", seconds))
end

--- Dispatch a subcommand from arg[1].
---@param commands table<string, fun(): unknown?>
---@param usage string Usage message for unknown commands.
function M.dispatch(commands, usage)
	local cmd = arg[1]
	local fn = commands[cmd]
	if fn then
		local result = fn()
		if result ~= nil then
			print(result)
		end
	else
		io.stderr:write(usage .. "\n")
		os.exit(1)
	end
end

return M
