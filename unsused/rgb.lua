module = {}


function module:new()

end

--[[
a function to mimic css's rgb function so that it triggers vscodes color decorators
--]]
function module.rgb(arg1, arg2, arg3, arg4)
	local c = Color:new()

	local h = string.match(ina, "#%x%x%x%x%x%x") -- check for hex string or hex string
	-- check for hex string with alpha or hex string / but i've never used alpha hex in my life prob won't use
	-- local h = string.match(ina, "#%x%x%x%x%x%x%x%x") or string.match(ina, "#%x%x%x%x%x%x")
	
	if h ~= nil then -- if it looks like a hex string
		if #h == 7 then -- hex string
			r = string.sub(h, 2, 3)
			g = string.sub(h, 4, 5)
			b = string.sub(h, 6, 7)

			c.r = tonumber(r)
			c.g = tonumber(g)
			c.b = tonumber(b)
		else
			echo("not valid hexcode")
		end
	else if arg1 ~= nil and arg2 ~= nil and arg3 ~= nil then -- if it looks rgb


	end

	return c
end
	
	if string.match(arg1, "#%d%d%d%d%d%d") then -- hexcode
		r = string.sub(arg1, 2, 3)
		g = string.sub(arg1, 4, 5)
		b = string.sub(arg1, 6, 7)
		
	end

	return c

end

-- function module.rgba


return module