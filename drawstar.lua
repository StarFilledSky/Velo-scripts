local success, util = pcall(require, "Velo\\scripts\\skyutil")
if not success then
    echo("Module failed to load: " .. util)
    return
end

local cos, sin = math.cos, math.sin

-- track sequence hosts tracks. tracks can have actions that modify actors


local TrackSequence = {}
local Track = {}
local Action = {} -- i could do something more similar to keyframes here
local AnimActor = {}


function AnimActor:new(_pos, _scale, _rot, _visible)
    local obj = AnimActor
    setmetatable(obj, AnimActor)
    
    self.visible = true or _visible
    self.pos = _pos or Vector2(0, 0)
    self.scale = _scale or Vector2(1, 1)
    self.rot = _rot or 0

    return obj
end

function Track:new(position, length)
    self.timelinePosition = 0
    self.update = function(delta) end
    self.render = function(delta) end
end

function TrackSequence:new()

end
        

-- local star = AnimActor:new()

local starPoints = {}
local degToRad = math.pi / 180 -- multiply
local progress = 0
local loop = 2

local outerScale = 50
local insideScale = 15
local scale = 5
local breakpoint = 15 * degToRad

local offset = Vector2:new(800, 600)
local c = Color:new(255, 255, 255)

function init()



    for i = 1, 12 do
        table.insert(starPoints, Vector2:new(0, 0))
    end
end



function update()
    --     if isReleased(hotkey) then -- on press initialize the reset

    --     end
    local time = get("Velo.deltaSec")
    progress = progress + time
    offset.x = (sin(progress) - 0.5) * 100 + 600
    -- local pingpong = progress % (loop * 2)
    -- local t = pingpong < loop and pingpong or (loop * 2) - pingpong
    local t = progress % loop
    local change = easeOutExpo(normalize(0, loop, t))

    local rotationScale = 360 * 4
    local tmpTheta = (change * rotationScale * degToRad)

    for i = 1, 4, 1 do
        local grouping = ((i - 1) * 3) + 1

        starPoints[grouping].x = cos(tmpTheta - breakpoint) * insideScale
        starPoints[grouping].y = sin(tmpTheta - breakpoint) * insideScale
        starPoints[grouping] = vec2Multiply(starPoints[grouping], scale)
        starPoints[grouping] = vec2Add(starPoints[grouping], offset)

        starPoints[grouping + 1].x = cos(tmpTheta) * outerScale
        starPoints[grouping + 1].y = sin(tmpTheta) * outerScale
        starPoints[grouping + 1] = vec2Multiply(starPoints[grouping + 1], scale)
        starPoints[grouping + 1] = vec2Add(starPoints[grouping + 1], offset)

        starPoints[grouping + 2].x = cos(tmpTheta + breakpoint) * insideScale
        starPoints[grouping + 2].y = sin(tmpTheta + breakpoint) * insideScale
        starPoints[grouping + 2] = vec2Multiply(starPoints[grouping + 2], scale)
        starPoints[grouping + 2] = vec2Add(starPoints[grouping + 2], offset)

        tmpTheta = tmpTheta + (90 * degToRad)
    end

end

-- returns value between 0-1
function normalize(min, max, value)
    local norm = (value - min) / (max - min)
    return norm
end

function easeOutExpo(x)
    return x == 1 and 1 or 1 - (2 ^ (-10 * x))
end

function easeInOutQuint(x)
    if x < 0.5 then
        return 16 * x * x * x * x * x
    else
        return (1 - ((-2 * x + 2) ^ 5)) / 2
    end
end

function render()
    if #starPoints < 2 then
        return
    end

    drawTriangles({starPoints[1], starPoints[2], offset, starPoints[2], starPoints[3], offset, starPoints[4],
                   starPoints[5], offset, starPoints[5], starPoints[6], offset, starPoints[7], starPoints[8], offset,

                   starPoints[8], starPoints[9], offset, starPoints[10], starPoints[11], offset, starPoints[11],
                   starPoints[12], offset}, c)

    drawTriangles({starPoints[3], starPoints[4], offset, starPoints[6], starPoints[7], offset, starPoints[9],
                   starPoints[10], offset, starPoints[12], starPoints[1], offset}, c)

end

function vec2Add(vec1, vec2)
    if type(vec2) == "table" then
        return Vector2:new(vec1.x + vec2.x, vec1.y + vec2.y)
    else
        return Vector2:new(vec1.x + vec2, vec1.y + vec2)
    end
end

function vec2Multiply(vec1, vec2)
    if type(vec2) == "table" then
        return Vector2:new(vec1.x * vec2.x, vec1.y * vec2.y)
    else
        return Vector2:new(vec1.x * vec2, vec1.y * vec2)
    end
end

init()
update()
render()
onPostUpdate = update
onPostDraw = render
