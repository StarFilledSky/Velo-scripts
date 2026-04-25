-- @author sky!!
local rocketIds = nil
local scanRange = 4 * 3

function init()
    rocketIds = scanRockets()

end

function updateDebug()
    status, err = pcall(update)
    if not status then
        echoErr(err.Message)
    end
end

function update()
    local stunnedPlayers = getRocketStunnedPlayers()

end

function impactUpdate()

end

function idleRender()

end

function impactRender()

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