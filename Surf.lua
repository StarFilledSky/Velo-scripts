
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
    self.paused = false

    -- for detection
    self._was_surfing = false
    self._was_grounded = false

    -- angle margin of error for slope surfing
    self._error_margin = 2

    self._previous_position = get(self.player .. ".actor.position")
    self._previous_frame = -1

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
--]]
function Surf:update()
    if not get("Velo.isIngame") then
        return
    end

    -- variable resets
    self.surf_ended = false
    self.oversurfed = false
    self.paused = false
    
    -- pause checks
    if get("Offline Game Mods.physics.time scale") == 0 then
        self.paused = true
    end
    
    if get("Velo.isPlaybackRunning") then
        _current_frame = get("Velo.frame")
        if self._previous_frame == _current_frame then
            self._previous_frame = _current_frame
            self.paused = true
            return
        end
        self._previous_frame = _current_frame
    end 
    


    _current_position = get(self.player .. ".actor.position")
    _colliding = get(self.player .. ".isCollidingWithSolid")
    _jumping = get(self.player .. ".jumpHeld")
    _in_air = get(self.player .. ".isInAir")
    
    _angle = -Surf:getAngle(_current_position, self._previous_position) -- inverted because dealing with negative y being up is annoying

    _on_ground = get("Player.isOnGround")
    -- echo(tostring(_on_ground))
        

    -- tried replacing this with just a check if the angle is positive but got a lot of false positives
    -- i feel like there's a better solution but this just works for now
    _surf_angle_right = (_angle >= 45 - self._error_margin) and (_angle <= 45 + self._error_margin)
    _surf_angle_left = (_angle >= 135 - self._error_margin) and (_angle <= 135 + self._error_margin)
    _correct_surf_angle = _surf_angle_left or _surf_angle_right
    
    -- checking if all the requirements are met
    _is_surfing = _correct_surf_angle and _in_air and _colliding and not self._was_grounded


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

        self.oversurfed = not _on_ground

        -- _on_ground = get("Player.isOnGround")

        -- echo(tostring(self.oversurfed))
        -- js = get("Player.jumpState")
        
        -- for some fucking reason if i use tostring here on js it crashes sometimes
        -- i think it comes down to variable name ???? s crashes aaa doesn't who fucking knows
        -- status, _jumpstate_str = pcall(tostring, js)
        -- if not status then
        --     echoErr(_jumpstate_str.Message)
        -- else
        -- end
        -- echo("".._jumpstate_str)
        
        -- echo("js" .. js)
        -- s = tostring(test) -- sometimes trying to acceess jumpstate just crashes the program ???
        aaa = "" .. tostring(_in_air) .. " | " .. tostring(_colliding) .. " | " .. tostring(_angle) .. " | " .. tostring(self._was_grounded) .. " | " .. tostring(_on_ground)
        echo(aaa)
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

