-- the original attempt at rendering an image with drawColoredTriangles
-- img.lua has more notes


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
	tri_arr["colors"] = {}
	tri_arr["vecs"] = {}
	offset_x = offset_x or 0
	offset_y = offset_y or 0
	s = 10 -- scale


	for x, x_data in ipairs(ppm_arr) do

		for y, pixel_data in ipairs(x_data) do

			--top left half of triangles
			table.insert(tri_arr["vecs"], Vector2:new((x - 1) * s, (y - 1) * s)) -- top left
			table.insert(tri_arr["vecs"], Vector2:new(x * s, (y - 1) * s)) -- top right
			table.insert(tri_arr["vecs"], Vector2:new((x - 1) * s, y * s)) -- bottom right
			
            table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
            table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
            table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
            table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
            table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
            table.insert(tri_arr["colors"], Color:new(pixel_data[1], pixel_data[2], pixel_data[3]))
			
			--bottom right half of triangles
			table.insert(tri_arr["vecs"], Vector2:new((x - 1) * s, y * s)) -- bottom right
			table.insert(tri_arr["vecs"], Vector2:new(x * s, (y - 1) * s)) -- top right
			table.insert(tri_arr["vecs"], Vector2:new(x * s, y * s)) -- bottom right

			

		end
	end
	return tri_arr
end




local data = Read_PPM("c:\\Home\\Projects\\test\\boxes_1.ppm")
local img = GenImg(data)
onPostDraw = function()

	drawColoredTriangles(img["vecs"], img["colors"])


end