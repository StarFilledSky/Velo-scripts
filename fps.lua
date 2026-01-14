-- drop fps to 60 when not in game
-- would suggest adding this to the run.lua file to have it run from start
-- run("fps")


local capped = 60
local max = 300

local frame_limit = "Performance.framerate.framelimit"

onPostUpdate = function()
    fps = getSt(frame_limit)
    in_game = get("Velo.isIngame")

    if in_game and fps ~= max then
        setSt(frame_limit, max)
    elseif not in_game and fps ~= capped then
        setSt(frame_limit, capped)
    end
end