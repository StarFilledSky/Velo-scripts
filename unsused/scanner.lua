
--[[
a script to return a list of lua scripts in a directory
this shouldn't be a seperate file tbh
todo move this into #
--]]

script_directories = {}


local handle = io.popen("dir")
local result = handle:read("*a")
handle:close()