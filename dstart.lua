--[[ delayed start
A velo script for Speedrunners that resets a solo run lap with a delay
--]]


--[[PROGRAM VARIABLES]]
timer = 0
countdown_start = 0
countdown_end = 0
display_time = ""

state = 0
STANDBY = 0
INITIALIZATION = 1
COUNTDOWN = 2

width = get("Velo.screenWidth")
height = get("Velo.screenHeight")



--[[USER CHANGABLE VARIABLES]]
hotkey_countdown_timer = 0.5 -- how long before the lap resets when the hotkey is pressed in seconds
lap_countdown_timer = 1.5 -- how long before the lap resets in seconds on completion of a lap
display_num = 3 -- the number the display counts down from is real_time_display is false 3..2..1..
real_time_display = false -- whether it counts down from the display number or the realtime 
restart_on_lap = true -- whether the countdown starts on every new lap
-- display text settings

pos = Vector2:new(0, 0)
size = Vector2:new(width, height)
alignment = Vector2:new(0.5, 0.2) -- % relative position from the pos variable
scale = 2
rotation = 0
font = "UI\\Font\\Souses.ttf"
font_size = 40
drop_shadow = true -- drop shadow
c = Color:new(252, 147, 170)



-- fires when inputs are polled
onSetInputs = function()
    -- keys https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
    key = 0x42
    if isReleased(key) and state == STANDBY then -- on press initialize the reset
        state = INITIALIZATION
        timer = hotkey_countdown_timer
    elseif isReleased(key) and state == COUNTDOWN then -- stops the timer if pressed again
        state = STANDBY
    end
end

onLapFinish = function()
    if restart_on_lap then
        state = INITIALIZATION
        timer = lap_countdown_timer
    end
end

onPostUpdate = function()
    if state == INITIALIZATION then
        state = COUNTDOWN
        countdown_start = get("Velo.realTime")
        -- converted to int to avoid issues with double * int
        countdown_end = countdown_start + math.tointeger(timer * TICKS_PER_SECOND)

    elseif state == COUNTDOWN then
        countdown_current = get("Velo.realTime") -- gets system time in game ticks
        
        if countdown_current > countdown_end then
            state = STANDBY
            resetLap()

        else
            elapsed_time = ((countdown_current - countdown_start) /  TICKS_PER_SECOND)
            
            if real_time_display then
                display_time = "Resetting in " .. string.format("%.2f", timer - elapsed_time) 
            else
                -- mapping the countdown value to a 3,2,1 or whatever the display_num starts with
                mapped_elapse = elapsed_time * (display_num / timer)
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