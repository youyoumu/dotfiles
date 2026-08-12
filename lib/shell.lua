---@class shell
local posix = require("posix")
local M = {}

--- Run a command with individual arguments and return its output.
---@param ... string Command and arguments to execute, passed as argv (no shell).
---@return string output The stdout of the command.
---@return integer status Exit status of the command.
function M.run(...)
	local argv = { ... }
	---@diagnostic disable-next-line: undefined-field
	local pipe = posix.popen(argv, "r")
	if not pipe then
		error("failed to run: " .. table.concat(argv, " "))
	end
	local chunks = {}
	while true do
		---@diagnostic disable-next-line: undefined-field
		local chunk = posix.read(pipe.fd, 4096)
		if not chunk or chunk == "" then
			break
		end
		chunks[#chunks + 1] = chunk
	end
	---@diagnostic disable-next-line: undefined-field
	local _, status = posix.pclose(pipe)
	return table.concat(chunks), status
end

--- Read a file and return its contents.
---@param path string
---@return string content
function M.read_file(path)
	local handle = assert(io.open(path, "r"))
	local content = handle:read("*a")
	handle:close()
	return content
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
