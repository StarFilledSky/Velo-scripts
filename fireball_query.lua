
-- active fireball scanning
-- author: sky!!
--[[

--]]
local announced = {}
local poll_rate = 0 -- arbitrary number here to reduce the amount of calls, should probably base on framerate
local poll = 0

onPostUpdate = function()
    poll = poll + 1
    if poll < poll_rate then
        return
    else
        poll = 0
    end

    if not get("Velo.isIngame") then
        return;
    end

    local player_count = get("Player.playerCount")
    
    for i = 0, (player_count - 1) * 3 do -- scan the default 3 balls for each player
        
        local ball = "Fireball#" .. i
        local life_timer = get(ball .. ".lifeTimer")

        if life_timer > 0 then
            
            local hits = get(ball .. ".hitPlayers") -- fairly sure this doesn't include the player that sent it
            if #hits >= 3 and not announced[ball] then
                
                announced[ball] = true
                echo("hit 3 people")
                
                for k, v in pairs(hits) do -- lists the players hit by ball by like Player#0 or PlayerBot#1
                    echo(v)
                end
            end
        else
            announced[ball] = false
        end
    end
end

    -- scrapped for being too laggy and also bugged
    -- local player_count = get("Player.playerCount")
    -- for i = 0, player_count - 1 do -- check for off by 1 here
    --     local player = "Player#" .. i
    -- -- doesn't seem like it works for players 1-3, idk if it's something to do with testing local and online works or if you can only check the main player
    --     local fireballs = get(player .. ".fireballs") 
    --     local active = true
    --     local fireball_index = 0
    --     for _, ball in pairs(fireballs) do
    --         echo(ball)
    --         life_timer = get(ball .. ".lifeTimer")
    --         -- if type(life_timer)
    --         -- echo(tostring())
    --         -- if life_timer > 0 then
    --         --     hits = get(ball .. ".hitPlayers")
    --         --     data = data .. "ball hit:\n" 
                
    --         --     for k, v in pairs(hits) do
    --         --         data = data .. v .. "\n"
    --         --     end
                
    --         -- end
        
    --     end
        
    -- end

    

    