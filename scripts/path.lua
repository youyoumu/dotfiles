#!/usr/bin/env lua

local path_var = os.getenv("PATH")

if path_var then
	for dir in path_var:gmatch("[^:]+") do
		print(dir)
	end
else
	print("PATH environment variable is not set.")
end
