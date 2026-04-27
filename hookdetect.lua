-- @author sky!!
-- @encoidng utf-8
-- @description: A simple example script for how to detect the player 


-- Player.isShooting
-- active when hook initially used and when pulling towards someone

-- Player.goldenHook.grabbed
-- returns nil unless a player is actively grabbed by the focus

local oneTimeTrigger = false -- for triggering only on the first notice of a character being grabbed
onPostUpdate = function()

    local isShooting = get("Player.isShooting")
    
    
    if isShooting then

        local hookVictim = get("Player.goldenHook.grabbed")
        
        if hookVictim ~= nil and oneTimeTrigger == false then -- triggers once and then resets when 
            oneTimeTrigger = true

            -- do voice event stuff here
                playSound("Audio\\Sfx\\Weapons\\ch_freeze.xnb", 1, 0, 0)

        end
    else
        oneTimeTrigger = false -- trigger reset when golden hook not extending
    end
end