
Surf = {}


-- i kinda flipped the name positions testing something and forgot about it
-- just going to leave it as is if it works ig
-- nvm i flipped it back probably won't break anything
-- don't need to reverse polarity of angle
function Surf:getAngle(p_start, p_end) -- two Vector2
    angle = math.atan(p_end.y - p_start.y, p_end.x - p_start.x)
    degrees = 180 * (angle/math.pi)
    return degrees
end


function Surf:new(player_number)
    obj = {}
    setmetatable(obj, self)
    self.__index = self

    if player_number == nil then
        self.player = "Player"
    else
        self.player = "Player#" .. tostring(player_number)
    end


    -- main variables to be checked by the user
    self.surf_started = false
    self.surfing = false


    -- for detection
    self.was_surfing = false
    self.was_grounded = true

    -- angle margin of error for slope surfing
    self.error_margin = 2

    self.previous_position = get(self.player .. ".actor.position")

    return obj
end

--[[
conditions for a slope surf
the player must have been in the air previously(not just jumping from ontop a slope already)
the player must be colliding with terrain
the player must be holding jump
the player must be moving upwards at a ~45°/~135° angle (i think i could replace this with something else tbh)
--]]
function Surf:update()
    if get("Offline Game Mods.physics.time scale") == 1 or not get("Velo.isIngame") then
        return
    end
    

    current_position = get(self.player .. ".actor.position")
    colliding = get(self.player .. ".isCollidingWithSolid")
    jumping = get(self.player .. ".jumpHeld")
    in_air = get(self.player .. ".isInAir")

    angle = Surf:getAngle(current_position, self.previous_position) -- inverted because dealing with negative y being up is annoying
    surf_angle = false

    -- tried replacing this with just a check if the angle is positive but got a lot of false positives
    -- i feel like there's a better solution but this just works for now
    if (angle >= 45 - self.error_margin) and (angle <= 45 + self.error_margin) then -- surfing right
        surf_angle = true
    end

    if (angle >= 135 - self.error_margin) and (angle <= 135 + self.error_margin) then -- surfing left
        surf_angle = true
    end

    
    if surf_angle and jumping and in_air and colliding and not was_grounded then
        is_surfing = true
    else
        is_surfing = false
    end

    if is_surfing and not self.was_surfing then -- start of surf
        self.was_surfing = true

        self.surf_started = true
        self.surfing = true



    elseif self.was_surfing and is_surfing then -- currently surfing
        self.surf_started = false
        self.surfing = true

    elseif self.was_surfing and not surfing then -- end of surf
        self.was_surfing = false
        self.was_grounded = true

        self.surf_started = false
        self.surfing = false

    end

    




    -- this is for when you're already on a slope and jump, doesn't count as a surf
    if not in_air and colliding then -- on the ground
        self.was_grounded = true
    elseif in_air and colliding and self.was_grounded then -- was just on the ground but in the air now invalid surf
        self.was_grounded = true
    else
        self.was_grounded = false
    end

    self.previous_position = current_position

end



return Surf

