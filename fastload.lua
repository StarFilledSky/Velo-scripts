-- fastload.lua
-- skips the annoying countdown when you enter the map by
-- speeding up the physics by 10 for 0.4 seconds
-- restoring it to regular phyics
-- resetting the lap


local in_map = get("Velo.isIngame") and not get("Velo.isOnline")

-- using onPostUpdate over onRoundStart because round start only fires after countdown
onPostUpdate = function()

    local status = get("Velo.isIngame") and not get("Velo.isOnline")

    if status and not in_map then
        in_map = true
        
        setSt("Offline Game Mods.physics.time scale", 10)
        await(wait(0.4))
        setSt("Offline Game Mods.physics.time scale", 1)
        resetLap()

    elseif not status then
        in_map = false
        
    end


end
