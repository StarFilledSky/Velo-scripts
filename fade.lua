
-- todo logarithmic lighten 

local width = get("Velo.screenWidth")
height = get("Velo.screenHeight")
 
local pos = Vector2:new(0, 0)
local size = Vector2:new(width, height)

local alpha = 0

local max = 100
local darken_rate = 3 -- the speed at which the screen darkens
local lighten_rate = 0.1 -- the speed at which the screen returns to normal

-- p sure this isn't framerate dependent bt whatever
onPostUpdate = function()
    dt = get("Velo.delta")
    a = get("Player.boostHeld")
    b = get("Player.isUsingBoost")
    -- echo(tostring(alpha))
    -- echo(tostring(dt))
    if a and b then 
        alpha = alpha + (darken_rate)
    else
        alpha = alpha - (lighten_rate)
    end

    if alpha > 255 then
        alpha = 255
    end

    if alpha < 0 then
        alpha = 0
    end


end

-- ontop of last layer so you can atleast see velo
onPostDrawLayer = function(layer)

    if layer == "TrailInFrontOfLocalPlayersLayer" then

        drawRect(pos, size, Color:new(0, 0, 0, alpha))

    end

end
