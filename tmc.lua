-- track mania style checkpoints

--[[
todo



enable player to draw checkpoints
enable player to save checkpoints
draw checkpoint hitboxes
generate checkpoints from leaderboard run

checkpoint crossover detection
comparison to run checkpoint time

--]]


local Checkpoint = {}
Checkpoint.__index = Checkpoint

function Checkpoint:new(x1, y1, x2, y2, crossing_time)
    local obj = {}
    setmetatable(obj, Checkpoint)
    local x1 = x1
    local y1 = y1
    local x2 = x2
    local y2 = y2
    local crossing_time = crossing_time

    return obj
end
