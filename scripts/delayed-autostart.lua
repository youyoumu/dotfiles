#!/usr/bin/env lua

local shell = require("lib.shell")
local sleep, background = shell.sleep, shell.background

sleep(1)
background("ghostty", "+new-window")

sleep(1)
background("microsoft-edge", "--disable-features=GlobalShortcutsPortal")

sleep(5)
background("discord", "--ozone-playform-hint=auto", "--enable-wayland-ime", "--wayland-text-input-version=3")
background("antimicrox", "--hidden")

sleep(10)
background("anki")
