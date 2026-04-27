--[[
this was an attempt to draw images using drawColoredTriangles
 i was thinking draw triangles might be pretty efficient since you send it as a buffer of points
but rendering tiny test images dropped the framerate massively(10-16 fps). i wonder if it's the color blending functionality.
i think i tried it with rect but i don't remember actually, if i did it wasn't much better though otherwise i would remember
 i loaded ppm files to an array of triangle points and rendered each pixel to a triangle
 --]]
 
 
--  function readPPM(file_path)
	--	file = io.open(file_path, "rb")


--     if file == nil then
--         echo("couldn't find the file")
--         return
--     end

--     magic_code = file:read("*line")
--     if magic_code ~= "P6" then
--         echo("couldn't find the file")
--         return
--     end
	
-- 	size = file:read("*line")
--     size_x = string.match(size, "%d+")
--     size_y = string.match(size, "%s%d+")

--     img_content = io.read("*all")


-- end


local success, skyutil = pcall(require, "Velo\\scripts\\skyutil")
if not success then
    print("Module failed to load: " .. skyutil)
end


function Read_PPM( filename )
    local fp = io.open( filename, "rb" )    
    if fp == nil then return nil end

    local data = fp:read( "*line" )
    if data ~= "P6" then return nil end
 
    data = fp:read( "*line" )

    local image = {}
    local size_x, size_y
    
    size_x = string.match( data, "%d+" )
    size_y = string.match( data, "%s%d+" )

    data = fp:read( "*line" )
    if tonumber(data) ~= 255 then return nil end

    for i = 1, size_x do
        image[i] = {}
    end
 
    for j = 1, size_y do
        for i = 1, size_x do
            image[i][j] = { string.byte( fp:read(1) ), string.byte( fp:read(1) ), string.byte( fp:read(1) ) }
        end
    end
 
    fp:close()
 
    return image
end




function GenImg(ppm_arr, offset_x, offset_y)
	local tri_arr = {}
	-- tri_arr["colors"] = {}
	-- tri_arr["vecs"] = {}
	offset_x = offset_x or 0
	offset_y = offset_y or 0
	s = 10 -- scale


	for x, x_data in ipairs(ppm_arr) do
			tri_arr[x] = {}
		for y, pixel_data in ipairs(x_data) do
			tri_arr[x][y] = {}
			tri_arr[x][y]["vecs"] = {}

			--top left half of triangles
			table.insert(tri_arr[x][y]["vecs"], Vector2:new((x - 1) * s, (y - 1) * s)) -- top left
			table.insert(tri_arr[x][y]["vecs"], Vector2:new(x * s, (y - 1) * s)) -- top right
			table.insert(tri_arr[x][y]["vecs"], Vector2:new((x - 1) * s, y * s)) -- bottom right
			
			tri_arr[x][y]["color"] = Color:new(pixel_data[1], pixel_data[2], pixel_data[3])

			--bottom right half of triangles
			-- table.insert(tri_arr["vecs"], Vector2:new((x - 1) * s, y * s)) -- bottom right
			-- table.insert(tri_arr["vecs"], Vector2:new(x * s, (y - 1) * s)) -- top right
			-- table.insert(tri_arr["vecs"], Vector2:new(x * s, y * s)) -- bottom right


		end
	end
	return tri_arr
end


-- returns tri_arr[y][x][vec|color]
-- function GenImg(ppm_arr, offset_x, offset_y)
-- 	local tri_arr = {}
-- 	tri_arr["colors"] = {}
-- 	tri_arr["vecs"] = {}
-- 	offset_x = offset_x or 0
-- 	offset_y = offset_y or 0
-- 	s = 5 -- scale

-- 	for x, x_data in ipairs(ppm_arr) do
-- 		for y, pixel_data in ipairs(x_data) do
-- 			table.insert(tri_arr["vecs"], Vector2:new((x - 1) * s, (y - 1) * s)) -- top left
-- 			table.insert(tri_arr["vecs"], Vector2:new(x * s, (y - 1) * s)) -- top right
-- 			table.insert(tri_arr["vecs"], Vector2:new((x - 1) * s, y * s)) -- bottom right
			
-- 			-- table.insert(tri_arr["vecs"], Vector2:new((x - 1) * s, y * s)) -- bottom right
-- 			-- table.insert(tri_arr["vecs"], Vector2:new(x * s, (y - 1) * s)) -- top right
-- 			-- table.insert(tri_arr["vecs"], Vector2:new(x * s, y * s)) -- bottom right
-- 			-- i want to gen a square out of triangles
-- 			table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
-- 			-- table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
-- 			-- table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))

-- 			-- table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
-- 			-- table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
-- 			-- table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
			
-- 			-- i want to gen the color data for the array
			
			
-- 		end
-- 	end
-- 	return tri_arr
-- end
--[[
    drawTriangles({
		Vector2:new(0, 0),
		Vector2:new(width, 0),
            Vector2:new(width / 2, height / 2),

            Vector2:new(width / 2, height / 2),
            Vector2:new(width, height),
            Vector2:new(0, height)
        },
        Color:new(255, 0, 0)
    )
--]]

-- local data = Read_PPM("c:\\Home\\Projects\\test\\8-2284493317.ppm")
-- local data = Read_PPM("c:\\Home\\Projects\\test\\house_1.ppm")
local data = Read_PPM("c:\\Home\\Projects\\test\\boxes_1.ppm")
-- local data = Read_PPM("c:\\Home\\Projects\\test\\test.ppm")



local img = GenImg(data)

-- echo(tostring(img[1][1]["color"][1]))

onPostDraw = function()
	for x, x_data in pairs(img) do
		for y, a in pairs(x_data) do
			-- echo(tostring(a["color"][1]))
			drawTriangles(a["vecs"], a["color"])
		end
	end
	-- drawColoredTriangles(img["vecs"], img["colors"])

	-- for key, value in pairs({table.unpack(img["vecs"], 1, 3)}) do
	-- 	draw
	-- end

end
