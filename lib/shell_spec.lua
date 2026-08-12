---@param T test
return function(T)
	local shell = require("lib.shell")

	T.test("run returns command output", function()
		local out = shell.run("echo", "hello")
		T.assert_eq(out:match("^hello"), "hello")
	end)

	T.test("run joins args with spaces", function()
		local out = shell.run("expr", "1", "+", "2")
		T.assert_eq(out:match("^3"), "3")
	end)

	T.test("run passes args as argv without a shell", function()
		local out, status = shell.run("printf", "[%s]", "a b")
		T.assert_eq(out:match("^%[(.-)%]"), "a b")
		T.assert_eq(status, 0)
		local literal = shell.run("echo", "$HOME")
		T.assert_eq(literal:match("^$HOME"), "$HOME")
	end)

	T.test("read_file returns file contents", function()
		local out = shell.read_file("lib/shell.lua")
		T.assert_truthy(out:match("function M%.read_file"))
	end)

	T.test("dispatch calls matching command", function()
		local called = false
		local old_arg = arg
		arg = { [1] = "hello" }
		shell.dispatch({
			hello = function()
				called = true
			end,
		}, "usage: test")
		arg = old_arg
		T.assert_truthy(called)
	end)

	T.test("dispatch prints return value", function()
		local old_arg = arg
		arg = { [1] = "greet" }
		local output = {}
		local old_print = print
		print = function(x)
			output[#output + 1] = x
		end
		shell.dispatch({
			greet = function()
				return "hi"
			end,
		}, "usage: test")
		print = old_print
		arg = old_arg
		T.assert_eq(output[1], "hi")
	end)

	T.test("dispatch exits on unknown command", function()
		local old_arg = arg
		arg = { [1] = "nope" }
		local old_exit = os.exit
		local exit_code = nil
		---@diagnostic disable-next-line: duplicate-set-field
		os.exit = function(code)
			exit_code = code
		end
		shell.dispatch({}, "usage: test")
		os.exit = old_exit
		arg = old_arg
		T.assert_eq(exit_code, 1)
	end)
end
