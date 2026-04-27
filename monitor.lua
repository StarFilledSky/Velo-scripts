local pos = Vector2:new(900, 200) -- x and y pixel position on the screen starts from top left
local size = Vector2:new(0, 0)
local alignment = Vector2:new(0.5, 0.2) -- % relative position from the pos variable
local scale = 1
local rotation = 0
local font = "UI\\Font\\GOTHICB.TTF" -- starts from the content folder where sr is
local font_size = 65
local drop_shadow = true -- drop shadow
local c = Color:new(252, 147, 170)

local text = ""

-- local jump_started = 0

-- local previous_actor_velocity = get("Player.actor.velocity")
-- local previous_position = get("Player.actor.position")

-- function subtractV2(v1, v2)
--     value = Vector2:new(v1.x - v2.x, v1.y - v2.y)
--     return value
-- end

-- local REFRESH_INTERVAL = 0.1
-- local refreshTimer = 0
prev_time = 0
ingame = true

onPostUpdate = function()
    ingame = get("Velo.isIngame")
    if not ingame then
        return
    end
    text = "test " .. tostring(get("Player.stunnedById"))
end

    -- text = "colliding: " .. tostring(get("Player.isCollidingWithSolid"))
    -- text = text .. " | inair: " .. tostring(get("Player.isInAir"))
    

    -- if get("Velo.isPlaybackRunning") then
    --     current_frame = get("Velo.frame")
    --     if previous_frame == current_frame then
    --         previous_frame = current_frame
    --         paused = true
    --         return
    --     end
    --     previous_frame = current_frame
    -- end 

    -- time = get("Velo.realDeltaSec")
    -- current_actor_velocity = get("Player.actor.velocity")
    -- current_position = get("Player.actor.position")

    -- refreshTimer = refreshTimer - time
    -- -- if refreshTimer <= 0 then
    -- refreshTimer = REFRESH_INTERVAL
    -- current_velocity = subtractV2(current_position, previous_position)
    -- text = "x: " .. current_velocity.x .. " y: " .. current_velocity.y 
    -- text = string.format("%0000.0f %0000.0f | %0000.0f %0000.0f", current_velocity.x * 300, current_velocity.y * 300, previous_actor_velocity.x, previous_actor_velocity.y)
    -- text = text .. "    " .. tostring(get("Player.isOnGround"))
    
    -- text = tostring(get("Player.groundCollidableType"))
    
    -- end
    -- val = get("Player.jumpState") -- jump state relates to the amount of jumps you have ig
    -- val = get("Player.groundCollidableType")
    -- val = get("Velo.isPaused") -- doesn't handle replay pauses
    -- jumpVelocity
    --todo check how long on jump state
    --what happens if you press and release jump in that .25 window
    -- text = tostring(val)

    -- previous_position = current_position
    -- previous_actor_velocity = current_actor_velocity


onPostDraw = function()
    if not ingame then
        return
    end

    drawText(text
    ,pos
    ,size
    ,alignment
    ,scale
    ,rotation
    ,font
    ,font_size
    ,drop_shadow
    ,c)


    -- position = get("Player.actor.position")
    -- velocity = get("Player.actor.velocity")
    -- hitboxSize = Vector2:new(25, 45) -- the player's hitbox
    -- center = position + hitboxSize / 2
    -- startPos = worldToScreen(center)
    -- endPos = worldToScreen(center + velocity)
    -- drawLine(startPos, endPos, 3, Color:new(255, 0, 0))
end