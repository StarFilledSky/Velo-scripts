-- can't use outside of game because it draws ontop of the ui and velo layers, annoying


local width = get("Velo.screenWidth")
local height = get("Velo.screenHeight")
local pos = Vector2:new(0, 0)
local size = Vector2:new(width, height)
local c = Color:new(255,255,255)
onPostDraw = function()
    drawRect(pos, size, c)
end