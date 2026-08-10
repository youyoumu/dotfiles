---@param T test
return function(T)
	local id = require("lib.id")

	T.test("nanoid returns correct length", function()
		local result = id.nanoid(16)
		T.assert_eq(#result, 16)
	end)

	T.test("nanoid defaults to 21", function()
		local result = id.nanoid()
		T.assert_eq(#result, 21)
	end)

	T.test("nanoid is hex", function()
		local result = id.nanoid(32)
		T.assert_truthy(result:match("^[%x]+$"))
	end)

	T.test("uuid has correct format", function()
		local result = id.uuid()
		T.assert_truthy(result:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-4%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$"))
	end)

	T.test("nanoid is unique", function()
		local a = id.nanoid(32)
		local b = id.nanoid(32)
		T.assert_neq(a, b)
	end)
end
