
local width = get("Velo.screenWidth")
local height = get("Velo.screenHeight")
local pos = Vector2:new(0, 0)
local size = Vector2:new(width, height)

local was_sliding = false
local alpha = 0
local dampen = 1.3

onPostUpdate = function ()
    if not get("Velo.inGame") then
        return
    end

    if alpha > 0 then
        alpha  = alpha - dampen
    end

    local sliding = get("Player.isSliding")

    if sliding and not was_sliding then
        was_sliding = true
        alpha = 255
        playSound("vineboom.wav", 10, 0, 0)
        setSt("Appearance.player.local color", Color:new(0,255,0))
    elseif not sliding and was_sliding then
        setSt("Appearance.player.local color", Color:new(255,255,255))
        was_sliding = false
    end


end

onPostDraw = function()
    -- drawRect(pos, size, Color:new(0, alpha, 0, alpha))
end

