
--[[ delayed start
A velo script for Speedrunners that resets a solo run lap with a delay

todo

- add restart on no movement -- don't think anyone would use this one tbh
- restart to a savestate

- test restart_on_stun
--]]


--[[PROGRAM VARIABLES]]
local wait_time = 0
local countdown_start = 0
local countdown_end = 0
local display_time = ""

local state = 0
local STANDBY = 0
local INITIALIZATION = 1
local COUNTDOWN = 2

local width = get("Velo.screenWidth")
local height = get("Velo.screenHeight")

--[[USER CHANGABLE VARIABLES]]
-- you can find the keys https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
local hotkey = 0x42 -- b by default

-- wait times for different resets in seconds
local hotkey_countdown_timer = 0.5 -- how long before the lap resets when the hotkey is pressed in seconds
local lap_countdown_timer = 1.5 -- how long before the lap resets on completion of a lap
stun_countdown_timer = 0.3 -- how long before the lap resets when the player is stunned

local display_num = 3 -- the number the display counts down from is real_time_display is false 3..2..1..
local real_time_display = false -- whether it counts down from the display number or the realtime 

local restart_on_hotkey = true -- on hotkey press
local restart_on_lap = true -- resets when a lap is completed
local restart_on_stun = false -- resets the lap when player is stunned
-- restart_on_no_movement = true -- not implemented




-- display text settings
local pos = Vector2:new(0, 0) -- x and y pixel position on the screen starts from top left
local size = Vector2:new(width, height)
local alignment = Vector2:new(0.5, 0.2) -- % relative position from the pos variable
local scale = 1 
local rotation = 0
local font = "UI\\Font\\GOTHICB.TTF" -- starts from the content folder where sr is
local font_size = 65
local drop_shadow = true -- drop shadow
local c = Color:new(252, 147, 170)


function stunCheck()
    if restart_on_stun then
        status = get("Player#0.isStunned")
        if status then
            state = INITIALIZATION
            wait_time = stun_countdown_timer
        end
    end
end



-- fires when inputs are polled
onSetInputs = function()
    if not restart_on_hotkey then
        return
    end

    if isReleased(hotkey) and state == STANDBY then -- on press initialize the reset
        state = INITIALIZATION
        wait_time = hotkey_countdown_timer
    elseif isReleased(hotkey) and state == COUNTDOWN then -- stops the countdown if pressed again
        state = STANDBY
        setSt("Offline Game Mods.physics.time scale", 1)
    end
end

onLapFinish = function()
    if restart_on_lap then
        state = INITIALIZATION
        wait_time = lap_countdown_timer
    end
end

onPostUpdate = function()
    if not get("Velo.isIngame") or get("Velo.isOnline") then
        state = STANDBY
        return
    end

    stunCheck()

    if state == INITIALIZATION then
        state = COUNTDOWN
        countdown_start = get("Velo.realTime")
        -- converted to int to avoid issues with double * int
        countdown_end = countdown_start + math.tointeger(wait_time * TICKS_PER_SECOND)
        -- pause at the start screen, doesn't invalidate a run somehow
        setSt("Offline Game Mods.physics.time scale", 0)
        resetLap()

    elseif state == COUNTDOWN then
        countdown_current = get("Velo.realTime") -- gets system time in game ticks
        
        if countdown_current > countdown_end then -- start lap
            state = STANDBY
            setSt("Offline Game Mods.physics.time scale", 1)

        else
            elapsed_time = ((countdown_current - countdown_start) /  TICKS_PER_SECOND)
            
            if real_time_display then
                display_time = "Resetting in " .. string.format("%.2f", wait_time - elapsed_time) 
            else
                -- mapping the countdown value to a 3,2,1 or whatever the display_num starts with
                mapped_elapse = elapsed_time * (display_num / wait_time)
                display_time = "Resetting in " .. tostring(math.floor(display_num + 1 - mapped_elapse))
            end
        end

    end
end

-- draws the countdown on the screen before the reset
onPostDraw = function()
    if state == COUNTDOWN then
        drawText(display_time, pos, size, alignment, scale, rotation, font, font_size, drop_shadow, c)
    end
end