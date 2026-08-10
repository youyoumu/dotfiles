#!/usr/bin/env lua

local shell = require("lib.shell")
local run, sleep = shell.run, shell.sleep
local id = require("lib.id")

local function timestamp()
	return os.date("%Y%m%d-%H%M%S")
end

local function screenshot_monitor()
	run("niri", "msg", "action", "screenshot-screen")
end

local function screenshot_region()
	run("niri", "msg", "action", "screenshot")
end

local function screenshot_window()
	run("niri", "msg", "action", "screenshot-window")
end

local function screenshot_region_delay()
	sleep(3)
	run("niri", "msg", "action", "screenshot")
end

local function screenshot_region_delay_annotate()
	sleep(3)
	local ts = timestamp()
	local tmp_path = "/tmp/screenshot-" .. ts .. "-" .. id.nanoid(8) .. ".png"
	local out_path = os.getenv("HOME") .. "/Pictures/Screenshots/satty-" .. ts .. ".png"

	run("niri", "msg", "action", "screenshot", "--path", tmp_path)

	local max_ticks = 120
	for _ = 1, max_ticks do
		local f = io.open(tmp_path, "r")
		if f then
			f:close()
			run("satty", "--filename", tmp_path, "--output-filename", out_path)
			os.remove(tmp_path)
			return
		end
		sleep(0.5)
	end

	io.stderr:write("Screenshot capture timed out or was cancelled.\n")
	os.exit(1)
end

shell.dispatch({
	monitor = screenshot_monitor,
	region = screenshot_region,
	window = screenshot_window,
	["region-delay"] = screenshot_region_delay,
	["region-delay-annotate"] = screenshot_region_delay_annotate,
}, "usage: screenshot.lua <monitor|region|window|region-delay|region-delay-annotate>")
