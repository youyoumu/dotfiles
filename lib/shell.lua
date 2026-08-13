---@class shell
local M = {}

local posix = require("posix")

--- Run a command with individual arguments and return its output.
---@param ... string Command and arguments to execute, passed as argv (no shell).
---@return string output The stdout of the command.
---@return integer status Exit status of the command.
function M.run(...)
	local argv = { ... }
	local pipe = posix.popen(argv, "r")
	if not pipe then
		error("failed to run: " .. table.concat(argv, " "))
	end
	local chunks = {}
	while true do
		local chunk = posix.read(pipe.fd, 4096)
		if not chunk or chunk == "" then
			break
		end
		chunks[#chunks + 1] = chunk
	end
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
	M.run("sleep", seconds)
end

--- Launch a command in the background without waiting for it to finish.
---@param ... string Command and arguments to execute, passed as argv (no shell).
---@return integer pid PID of the spawned process.
function M.background(...)
	local argv = { ... }
	local path = table.remove(argv, 1)
	local pid = posix.fork()
	if pid == nil then
		error("failed to fork")
	elseif pid == 0 then
		local devnull = posix.open("/dev/null", posix.O_RDWR)
		posix.dup2(devnull, posix.STDIN_FILENO)
		posix.dup2(devnull, posix.STDERR_FILENO)
		posix.dup2(devnull, posix.STDOUT_FILENO)
		posix.close(devnull)
		posix.execp(path, argv)
		os.exit(1)
	end
	return pid
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
