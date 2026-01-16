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


-- added a polling rate but i don't think it really matters here unless i'm sharing the polling variable with other programs
-- because this one only calls Velo.isInGame
-- i don't have a means for benchmarking atm so doesn't matter anyway

-- local capped = 60
-- local max = 300
-- local polling_rate = 0.5
-- local timer = polling_rate

-- local frame_limit = "Performance.framerate.framelimit"

-- onPostUpdate = function()
--     timer = timer - get("Velo.realDeltaSec")
--     if timer <= 0 then
--         timer = polling_rate + timer

--         fps = getSt(frame_limit)
--         in_game = get("Velo.isIngame")

--         if in_game and fps ~= max then
--             setSt(frame_limit, max)
--         elseif not in_game and fps ~= capped then
--             setSt(frame_limit, capped)
--         end
--     end
-- end