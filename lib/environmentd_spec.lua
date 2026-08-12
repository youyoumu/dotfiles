---@param T test
return function(T)
	local environmentd = require("lib.environmentd")

	T.test("parses simple assignments", function()
		local result = environmentd.parse_conf([[
FOO=bar
BAZ=qux
]])
		T.assert_eq(#result, 2)
		T.assert_eq(result[1].key, "FOO")
		T.assert_eq(result[1].value, "bar")
		T.assert_eq(result[2].key, "BAZ")
		T.assert_eq(result[2].value, "qux")
	end)

	T.test("preserves duplicates in order", function()
		local result = environmentd.parse_conf([[
PATH=/a
PATH=/b
]])
		T.assert_eq(#result, 2)
		T.assert_eq(result[1].value, "/a")
		T.assert_eq(result[2].value, "/b")
	end)

	T.test("skips comments", function()
		local result = environmentd.parse_conf([[
# comment
FOO=bar
# another
]])
		T.assert_eq(#result, 1)
		T.assert_eq(result[1].key, "FOO")
		T.assert_eq(result[1].value, "bar")
	end)

	T.test("skips blank lines", function()
		local result = environmentd.parse_conf([[
FOO=bar


BAZ=qux
]])
		T.assert_eq(#result, 2)
		T.assert_eq(result[1].value, "bar")
		T.assert_eq(result[2].value, "qux")
	end)

	T.test("joins continuation lines", function()
		local result = environmentd.parse_conf([[
MY_PATH=/a\
:/b
]])
		T.assert_eq(#result, 1)
		T.assert_eq(result[1].key, "MY_PATH")
		T.assert_eq(result[1].value, "/a:/b")
	end)

	T.test("keeps env vars literal", function()
		local result = environmentd.parse_conf("MY_HOME=$HOME/test")
		T.assert_eq(#result, 1)
		T.assert_eq(result[1].key, "MY_HOME")
		T.assert_eq(result[1].value, "$HOME/test")
	end)

	T.test("handles spaces around values", function()
		local result = environmentd.parse_conf("FOO = bar ")
		T.assert_eq(result[1].key, "FOO")
		T.assert_eq(result[1].value, "bar")
	end)

	T.test("returns empty table for empty content", function()
		local result = environmentd.parse_conf("")
		T.assert_eq(#result, 0)
	end)

	T.test("to_env outputs export statements", function()
		local result = environmentd.to_env({ { key = "FOO", value = "bar" } })
		T.assert_eq(result, 'export FOO="bar"')
	end)

	T.test("to_env escapes double quotes", function()
		local result = environmentd.to_env({ { key = "FOO", value = 'bar"baz' } })
		T.assert_eq(result, 'export FOO="bar\\"baz"')
	end)

	T.test("to_env escapes backslashes", function()
		local result = environmentd.to_env({ { key = "FOO", value = "bar\\baz" } })
		T.assert_eq(result, 'export FOO="bar\\\\baz"')
	end)

	T.test("to_env joins multiple entries in order", function()
		local result = environmentd.to_env({
			{ key = "A", value = "1" },
			{ key = "B", value = "2" },
		})
		T.assert_eq(result, 'export A="1"\nexport B="2"')
	end)

	T.test("to_env keeps duplicate keys in order", function()
		local result = environmentd.to_env({
			{ key = "PATH", value = "/a" },
			{ key = "PATH", value = "/b" },
		})
		T.assert_eq(result, 'export PATH="/a"\nexport PATH="/b"')
	end)
end