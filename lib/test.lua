---@class test
local M = {}
---@type { name: string, fn: fun() }[]
local tests = {}
local passed = 0
local failed = 0

--- Register a test case.
---@param name string Test name.
---@param fn fun() Test function.
function M.test(name, fn)
	tests[#tests + 1] = { name = name, fn = fn }
end

--- Assert two values are equal.
---@param actual unknown
---@param expected unknown
function M.assert_eq(actual, expected)
	if actual ~= expected then
		error(string.format("expected %s, got %s", tostring(expected), tostring(actual)), 2)
	end
end

--- Assert two values are not equal.
---@param actual unknown
---@param expected unknown
function M.assert_neq(actual, expected)
	if actual == expected then
		error(string.format("expected not %s", tostring(expected)), 2)
	end
end

--- Assert a value is truthy.
---@param val unknown
function M.assert_truthy(val)
	if not val then
		error(string.format("expected truthy, got %s", tostring(val)), 2)
	end
end

--- Assert a function throws an error.
---@param fn fun()
function M.assert_error(fn)
	local ok = pcall(fn)
	if ok then
		error("expected error, none thrown", 2)
	end
end

--- Run all registered tests and exit with status.
function M.run()
	for _, t in ipairs(tests) do
		local ok, err = pcall(t.fn)
		if ok then
			passed = passed + 1
			print(string.format("  PASS  %s", t.name))
		else
			failed = failed + 1
			print(string.format("  FAIL  %s: %s", t.name, err))
		end
	end
	print(string.format("\n%d passed, %d failed", passed, failed))
	if failed > 0 then
		os.exit(1)
	end
end

return M
