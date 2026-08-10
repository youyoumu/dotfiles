---@param T test
return function(T)
	local environmentd = require("lib.environmentd")

	T.test("parses simple assignments", function()
		local result = environmentd.parse_conf([[
FOO=bar
BAZ=qux
]])
		T.assert_eq(result["FOO"], "bar")
		T.assert_eq(result["BAZ"], "qux")
	end)

	T.test("skips comments", function()
		local result = environmentd.parse_conf([[
# comment
FOO=bar
# another
]])
		T.assert_eq(result["FOO"], "bar")
		T.assert_eq(result["# comment"], nil)
		T.assert_eq(result["# another"], nil)
	end)

	T.test("skips blank lines", function()
		local result = environmentd.parse_conf([[
FOO=bar


BAZ=qux
]])
		T.assert_eq(result["FOO"], "bar")
		T.assert_eq(result["BAZ"], "qux")
	end)

	T.test("joins continuation lines", function()
		local result = environmentd.parse_conf([[
MY_PATH=/a\
:/b
]])
		T.assert_eq(result["MY_PATH"], "/a:/b")
	end)

	T.test("keeps env vars literal", function()
		local result = environmentd.parse_conf("MY_HOME=$HOME/test")
		T.assert_eq(result["MY_HOME"], "$HOME/test")
	end)

	T.test("handles spaces around values", function()
		local result = environmentd.parse_conf("FOO = bar ")
		T.assert_eq(result["FOO"], "bar")
	end)

	T.test("returns empty table for empty content", function()
		local result = environmentd.parse_conf("")
		T.assert_eq(next(result), nil)
	end)

	T.test("to_env outputs export statements", function()
		local result = environmentd.to_env({ FOO = "bar" })
		T.assert_eq(result, 'export FOO="bar"')
	end)

	T.test("to_env escapes double quotes", function()
		local result = environmentd.to_env({ FOO = 'bar"baz' })
		T.assert_eq(result, 'export FOO="bar\\"baz"')
	end)

	T.test("to_env escapes backslashes", function()
		local result = environmentd.to_env({ FOO = "bar\\baz" })
		T.assert_eq(result, 'export FOO="bar\\\\baz"')
	end)

	T.test("to_env joins multiple entries with newline", function()
		local result = environmentd.to_env({ A = "1", B = "2" })
		local ab = result:match('export A="1"\nexport B="2"')
		local ba = result:match('export B="2"\nexport A="1"')
		T.assert_truthy(ab or ba)
	end)
end
