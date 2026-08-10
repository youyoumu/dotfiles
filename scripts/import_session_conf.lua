#!/usr/bin/env lua

local environmentd = require("lib.environmentd")

local path = arg[1] or os.getenv("HOME") .. "/.config/environment.d/session.conf"
local conf = environmentd.load_conf(path)
print(environmentd.to_env(conf))
