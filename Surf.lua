
Surf = {}


-- i kinda flipped the name positions testing something and forgot about it
-- just going to leave it as is if it works ig
function Surf:getAngle(p_end, p_start) -- two Vector2
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
    self.surf_ended = false
    self.oversurfed = false
    self.paused = false -- if the physics are at 0 or a replay hasn't progressed a frame so that programs aren't repeating something 1000 times

    -- for detection
    self._was_surfing = false
    self._was_grounded = false

    return obj
end

--[[
conditions for a slope surf
the player must have been in the air previously(not just jumping from ontop a slope already)
the player must be colliding with terrain
the player must be in the air
the player must be moving with vertical momentum upwards at a ~45°/~135° angle (i think i could replace this with something else tbh)
the player must not be in a boost tunnel? todo test at some point
i think falling on boxes might trigger this so todo test that as well

conditions for oversurf
the player is still in the air after a surf is concluded
this might have weird interactions with gates todo test
i think double jump might also trigger this

--]]
function Surf:update()
    
    -- variable resets
    self.surf_ended = false
    self.oversurfed = false
    


    _current_position = get(self.player .. ".actor.position")
    _colliding = get(self.player .. ".isCollidingWithSolid")
    _jumping = get(self.player .. ".jumpHeld")
    _in_air = get(self.player .. ".isInAir")
    _in_boost_tunnel = get(self.player .. ".isInsideSuperBoost")
    _collision_type = get(self.player .. ".groundCollidableType")
    _surfable_tile = false

    
    
    
    _tile_types = {4, 5, 120}
    for i, t in ipairs(_tile_types) do
        if _collision_type == t then
            _surfable_tile = true
        end
    end

    
    -- checking if all the requirements are met
    _is_surfing = _surfable_tile and _in_air and _colliding and not self._was_grounded and not _in_boost_tunnel


    if _is_surfing and not self._was_surfing then -- start of surf
        self._was_surfing = true
        self.surf_started = true
        self.surfing = true

    elseif self._was_surfing and _is_surfing then -- currently surfing
        self.surf_started = false
        self.surfing = true

    elseif self._was_surfing and not _is_surfing then -- end of surf
        self._was_surfing = false
        self._was_grounded = true

        self.surf_started = false
        self.surfing = false
        self.surf_ended = true
        self.oversurfed = _in_air
    end

    
    -- this is for when you're already on a slope and jump, doesn't count as a surf
    if not _in_air and _colliding then -- on the ground
        self._was_grounded = true
    elseif _in_air and _colliding and self._was_grounded then -- was just on the ground but in the air now invalid surf
        self._was_grounded = true
    else
        self._was_grounded = false
    end

    self._previous_position = _current_position

end



return Surf

