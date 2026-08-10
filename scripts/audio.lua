#!/usr/bin/env lua

local shell = require("lib.shell")
local run = shell.run

---@alias sink_name string

---@class sink
---@field id number
---@field name sink_name
---@field active boolean

---@type table<sink_name, sink_name>
local renames = {
	["Starship/Matisse HD Audio Controller Digital Stereo (IEC958)"] = "Samsung Soundbar",
}

--- Parse wpctl status output into a list of sinks.
---@param status string
---@return sink[]
local function parse_wpctl_status(status)
	local sinks = {}
	local in_sinks = false
	for line in status:gmatch("[^\n]+") do
		if line:match("Sinks:") then
			in_sinks = true
		elseif in_sinks then
			if line:match("Sources:") or line:match("Filters:") or line:match("Streams:") then
				break
			end
			local id, desc = line:match("(%d+)%..-%s*(.-)%s*%[vol:")
			if id and desc then
				sinks[#sinks + 1] = {
					id = tonumber(id),
					name = renames[desc] or desc,
					active = line:match("%*") ~= nil,
				}
			end
		end
	end
	return sinks
end

--- Get the currently active audio sink.
---@return sink?
local function get_active_sink()
	local sinks = parse_wpctl_status(run("wpctl", "status"))
	for _, sink in ipairs(sinks) do
		if sink.active then
			return sink
		end
	end
	return nil
end

--- Cycle to the next audio sink.
---@return sink?
local function switch_sink()
	local sinks = parse_wpctl_status(run("wpctl", "status"))
	if #sinks == 0 then
		error("no sinks found")
	end

	local active_idx = 1
	for i, sink in ipairs(sinks) do
		if sink.active then
			active_idx = i
			break
		end
	end

	local next_idx = (active_idx % #sinks) + 1
	local next_sink = sinks[next_idx]

	run("wpctl", "set-default", tostring(next_sink.id))
	return next_sink
end

shell.dispatch({
	get = function()
		local sink = get_active_sink()
		return sink and sink.name
	end,
	switch = function()
		local sink = switch_sink()
		return sink and sink.name
	end,
}, "usage: audio.lua <get|switch>")
