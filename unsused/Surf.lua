
Surf = {}


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
 
    -- for detection
    self._was_surfing = false
    self._was_grounded = false
    self._prev_jump_time = 0


    return obj
end

--[[
conditions for a slope surf
the player must be in the air
the front of player must be colliding with terrain
the player must colliding with a surface that can be surfed on
the player must have been in the air previously(not just jumping from ontop a slope already)
the player must not be in a boost tunnel
the player must be within the 0.25 jumpstate window(?)
    // i don't think there's an easy way to detect jumpstate mid jump and that would cause some issues for replays
    // maybe checking if jump velocity is increasing and not at the max for it?
    // i think implementing jump state  would make it worse at detecting a surf if you rewind to after a jump but before a surf
    // and i don't think there would be anything to gain from it from what i have right now


conditions for oversurf
the player is still in the air after a surf is concluded
--]]
function Surf:update()
    
    -- variable resets
    self.surf_ended = false
    self.oversurfed = false
    
    -- means of detection
    -- gets the tile the player is on to check whether it's a surfable surface
    local _collision_type = get(self.player .. ".groundCollidableType")
    -- stops false positives in boost tunnels
    local _in_boost_tunnel = get(self.player .. ".isInsideSuperBoost")
    -- true when the player is moving into something and presumably getting pushed out in collision detection pass
    local _colliding = get(self.player .. ".isCollidingWithSolid")
    -- when in jump state the player counts as in the air even when they are touching
    -- when paired with collision checks, it's a good indicator of a slope surfing state with a lot of false positives though
    -- i think this could be swapped with isOnGround
    local _in_air = get(self.player .. ".isInAir")
    -- local _jump_held = get(self.player .. ".jumpHeld")
    -- local jt = get("Player.jumpTime")

    local _surfable_surface = false
    local _surfable_surfaces = {4, 5, 120} -- tiles for left slope, right slope, and gates

    -- checking if the player is on a tile that's surfable
    for _, t in pairs(_surfable_surfaces) do
        if _collision_type == t then
            _surfable_surface = true
        end
    end

    
    -- checking if all the requirements are met
    local _is_surfing = _surfable_surface and _in_air and _colliding and not self._was_grounded and not _in_boost_tunnel
    -- _is_surfing = _surfable_surface and _in_air and not self._was_grounded and not _in_boost_tunnel


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
    -- elseif _in_air and _colliding -- i need a case here for when the player isn't in jump state
    else
        self._was_grounded = false
    end

end



return Surf

