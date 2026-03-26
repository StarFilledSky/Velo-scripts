-- timed msg
-- shows a delayed message on the screen

--shit code that gets the job done 






echo("amount: " .. tostring(#arg))

if #arg ~= 2 then
    echo("error: takes 2 args for timed msg. was given " .. tostring(#arg) .. " arg(s)")
    echo(arg[0] .. " [time] [\"message\"]")
    return
end

local time = arg[1]
local msg = arg[2]

local time_start = get("Velo.realDeltaSec") -- delta in seconds
local fade_time = 0.5 -- second
local fade = fade_time

width = get("Velo.screenWidth")
height = get("Velo.screenHeight")

function draw_msg(text, x, y, fontsize, col)
    local pos = Vector2:new(0, 0)
    local bounds = Vector2:new(width, height)
    -- local bounds = Vector2:new(get("Velo.screenWidth"), get("Velo.screenHeight"))
    local alignment = Vector2:new(x or 0.8, y or 0.15)
    local scale = 1
    local rotation = 0
    local font = "Content\\UI\\Font\\NotoSans-Regular.ttf"
    local fs = font_size or 40
    local ds = true
    local c = col or Color:new(255, 255, 255)

    -- local background_bounds = measureText(text, font, fs)
    -- drawRect(pos, background_bounds, Color:new(255,255,255))

    drawText(
    text or ""
    ,pos
    ,bounds
    ,alignment
    ,scale
    ,rotation
    ,font
    ,fs
    ,ds
    ,c)

end

onPostDraw = function()
    if fade < 0 then
        exit()
    end
    
    local d_sec = get("Velo.realDeltaSec")
    
    if time > 0 then
        
        draw_msg(msg)
        
        time = time - d_sec
    else
        a = fade / fade_time
        v = 255 * a
        local c = Color:new(v,v,v,v)
        draw_msg(msg, nil, nil, nil, c)
        fade = fade - d_sec
    end
    
end