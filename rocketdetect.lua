-- @author sky!!
-- @encoding utf-8
-- @description: This is an example script for detecting rockets hitting players


-- @velofields

-- Rocket.actor.id
-- 
 
-- Player.stunnedById
-- By default this value sits at -2147483648, The negative max value of a long I think. 
-- When stunned, it gives the actor id of what stuned the player and we can compare
-- this to the objects in the game as they all count/have actors. 
-- If there's no player it just returns a table. Sometimes it returns nil? I forgot
-- to write down what causes that if I figured it out before. I think it might have had to do with alive playercount.


-- @Todo 
-- Bring back comments from previous commit
-- test edge cases like if you're already stunned on spikes and get hit by missle does the stun target change?

local rocketIds = nil
local scanRange = 4 * 3

function init()
    rocketIds = scanRockets()
end

function update()
    local stunnedPlayers = getRocketStunnedPlayers()

end

-- returns a list of rockets {{actorId, name}, ..}
function scanRockets()
    local rocketIds = {}

    for i = 0, scanRange, 1 do
        local rocket = "Rocket#" .. tostring(i)
        local id = get(rocket .. ".actor.id")

        if type(id) ~= "table" then
            local index = #rocketIds + 1
            rocketIds[index] = {}
            rocketIds[index]["actorId"] = id
            rocketIds[index]["name"] = rocket
        end
    end
    return rocketIds
end

-- Checks every player to see if they've been stunned
-- returns a list of players that have been stunned by rocket {{player, stunId, rocketStunned}}
function getRocketStunnedPlayers()
    local playersStatus = {}
    local playerMax = 4
    for i = 0, playerMax - 1, 1 do -- offset by 1 because game count starts from 0

        local player = "Player#" .. tostring(i)
        local stunId = get(player .. ".stunnedById")

        local validPlayer = type(stunId) ~= "table" and stunId ~= nil
        local stunnedByRocket = false

        if validPlayer then
            if stunId > 0 then
                stunnedByRocket = isStunnedByRocket(stunId)
            end
        end

        if stunnedByRocket then
            local data = {}
            data["player"] = player
            data["stunId"] = stunId

            table.insert(playersStatus, data)
        end

    end
    return playersStatus
end

-- Compares an actor id of what stunned a player to the list of known rockets
-- Returns bool
function isStunnedByRocket(stunActorId)

    for i = 1, #rocketIds, 1 do
        if rocketIds[i]["actorId"] == stunActorId then
            return true
        end
    end
    return false
end


init()
onPostUpdate = update