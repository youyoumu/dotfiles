local cjson = require("cjson")
local lyaml = require("lyaml")
local shell = require("lib.shell")
local id = require("lib.id")

---@return string archive path
local function fetch_mason_registry()
	local seed = tonumber(os.date("%Y%m%d"))
	local archive = "/tmp/mason-registry-" .. id.nanoid(8, seed) .. ".tar.gz"
	local _, ok = shell.run("test", "-s", archive)
	if ok ~= 0 then
		shell.run(
			"curl",
			"-fsSL",
			"https://codeload.github.com/mason-org/mason-registry/tar.gz/refs/heads/main",
			"-o",
			archive
		)
	end
	return archive
end

---@return string[][] [mason, nixpkgs, lspconfig?]
local function load_excluded_packages()
	local json = os.getenv("HOME") .. "/dotfiles/.config/nvim/lua/config/excluded-mason-packages.json"
	local packages = cjson.decode(shell.read_file(json))
	return packages
end

---@param archive string
---@return table<string, true>
local function load_mason_packages(archive)
	local packages = {}
	local listing = shell.run("tar", "-tzf", archive)
	for package in listing:gmatch("[^\n]+/packages/([^/]+)/package%.yaml") do
		packages[package] = true
	end
	return packages
end

---@return string[]|nil lspconfig alias
local function load_lspconfig_alias(archive, mason)
	local package_yaml = shell.run("tar", "-xOzf", archive, "mason-registry-main/packages/" .. mason .. "/package.yaml")
	local data = lyaml.load(package_yaml)
	if data and data.neovim and data.neovim.lspconfig then
		return data.neovim.lspconfig
	end
end

---@param T test
return function(T)
	T.test("excluded Mason packages have required fields", function()
		for _, package in ipairs(load_excluded_packages()) do
			assert(package[1], "missing mason field in excluded Mason package")
			assert(package[2], "missing nixpkgs field in excluded Mason package")
		end
	end)

	T.test("excluded Mason packages are valid Mason registry packages", function()
		local archive = fetch_mason_registry()
		local mason_packages = load_mason_packages(archive)

		for _, package in ipairs(load_excluded_packages()) do
			if not mason_packages[package[1]] then
				error("invalid Mason package: " .. package[1])
			end
		end
	end)

	T.test("excluded Mason lspconfig aliases match Mason registry metadata", function()
		local archive = fetch_mason_registry()

		for _, package in ipairs(load_excluded_packages()) do
			if package[3] then
				local actual = load_lspconfig_alias(archive, package[1])
				T.assert_eq(actual, package[3])
			end
		end
	end)

	T.test("excluded Mason packages include registry lspconfig aliases", function()
		local archive = fetch_mason_registry()

		for _, package in ipairs(load_excluded_packages()) do
			local actual = load_lspconfig_alias(archive, package[1])
			if actual then
				T.assert_eq(package[3], actual, "missing lspconfig alias for " .. package[1])
			end
		end
	end)
end
