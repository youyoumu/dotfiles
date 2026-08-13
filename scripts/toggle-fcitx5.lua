#!/usr/bin/env lua

local shell = require("lib.shell")
local run, background = shell.run, shell.background

local _, status = run("pgrep", "fcitx5")
if status == 0 then
	print("Killing fcitx5...")
	run("pkill", "fcitx5")
else
	print("Starting fcitx5...")
	background("fcitx5")
end
