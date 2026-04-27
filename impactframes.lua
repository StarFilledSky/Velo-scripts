-- @author sky!!
-- @encoding utf-8
-- @description: This is an example script for detecting rockets hitting players
--
-- @velofields
--
-- Rocket.actor.id
-- 
-- Player.stunnedById
-- By default this value sits at -2147483648, The negative max value of a long I think. 
-- When stunned, it gives the actor id of what stuned the player and we can compare
-- this to the objects in the game as they all count/have actors. 
-- If there's no player it just returns a table. Sometimes it returns nil? I forgot
-- to write down what causes that if I figured it out before. I think it might have had to do with alive playercount.
--
-- @Todo 
-- Bring back comments from previous commit
-- test edge cases like if you're already stunned on spikes and get hit by missle does the stun target change?
local windowWidth = get("Velo.screenWidth")
local windowHeight = get("Velo.screenHeight")

local rocketIds = nil
local scanRange = 4 * 3
local wasStunnedPlayers = {}

function init()
    rocketIds = scanRockets()
end

function update()
    local stunnedPlayers = getRocketStunnedPlayers()

    local newStunnedPlayers = {}

    -- if there's a player that isn't in wasStunnedPlayers fire a vfx event
    for k, v in pairs(stunnedPlayers) do
        if containsKey(wasStunnedPlayers, k) then
            table.insert(newStunnedPlayers, k)
        end
    end

    for i = 1, #newStunnedPlayers do
        echo("called")
        startImpact(newStunnedPlayers[i])
    end

    wasStunnedPlayers = stunnedPlayers
end

-- returns a list of rockets {actorId = name, ..}
function scanRockets()
    local rocketIds = {}

    for i = 0, scanRange, 1 do
        local rocket = "Rocket#" .. tostring(i)
        local id = get(rocket .. ".actor.id")

        if type(id) ~= "table" then
            rocketIds[id] = rocket
        end
    end
    return rocketIds
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

-- Checks every player to see if they've been stunned
-- returns a list of players that have been stunned by rocket {player = stunId, ..}
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
            playersStatus[player] = stunId
            local data = {}
            data["player"] = player
            data["stunId"] = stunId
            table.insert(playersStatus, data)
        end

    end
    return playersStatus
end

function containsValue(tbl, entry)
    for _, v in pairs(tbl) do
        if v == entry then
            return true
        end
    end
    return false
end

function containsKey(tbl, entry)
    for k, _ in pairs(tbl) do
        if k == entry then
            return true
        end
    end
    return false
end

-- awful code section 

-- local fxImpactClip = {}
-- -- track 0-1 value, visibility bool, func function, values args
-- local bgAnimation = {{
--     track = 0,
--     visibility = true,
--     func = screenCover,
--     values = {Color:new(255, 255, 255)}
-- }, {{
--     track = 0.3,
--     visibility = true,
--     func = screenCover,
--     values = {Color:new(255, 255, 255)}
-- }}}

local queue = {}

local Clip = {}
function Clip:new(length, anims)
    local obj = {}
    setmetatable(obj, Clip)
    obj.deltaSec = 0
    obj.position = 0
    obj.length = length
    obj.anims = anims
    return obj
end

function Clip:render(deltaSec)

    for i = 1, #self.anims, 1 do
        elapsedTime = (1 / self.anims["length"]) * self.deltasec
        self.anims[i](elapsedTime)
    end

    self.deltaSec = self.deltaSec + 1
end

function startImpact(player)

    table.insert(queue, Clip:new(1, {animtest}))
    echo("fired")

end

function vfxRender()
    local time = get("Velo.deltaSec")

    for _, animClip in pairs(queue) do
        animClip:render(time)

    end

    cleanQueue()
end

function animtest(stageTime)
    local stages = {0.25, 0.5, 1}
    
    if stageTime <= stages[1] then
        drawRect(Vector2:new(0, 0), Vector:new(windowWidth, windowHeight), Color:new(255, 255, 255))
    elseif stageTime <= stages[2] then
        drawRect(Vector2:new(0, 0), Vector:new(windowWidth, windowHeight), Color:new(0, 0, 0))
    elseif stageTime <= stages[3] then

    end
end

-- removes animations that have ended
function cleanQueue()
    local nextIndex = 1
    local len = #queue
    for i = 1, #queue, 1 do
        if queue["x"] <= queue["length"] then -- keep and move to the next index
            if i ~= nextIndex then
                queue[nextIndex] = queue[i]
            end
            nextIndex = nextIndex + 1
        else -- remove it leaving the spot open
            queue[i] = nil
        end
    end
end

init()
onPostUpdate = update
onPostRender = vfxRender

-- local starAnimation = {}

-- function vfxRender()
--     local time = get("Velo.deltaSec")

--     for _,v in pairs(queue) do
--         local x = 1 / v["length"] * v["time"]
--         v["func"](x, v["values"])

--         v["time"] = v["time"] + time
--     end

--     queue = cleanQueue(queue)
-- end

-- -- args: color
-- function screenCover(track, args)

--     drawRect(0, 0, wi)

-- end

-- -- draws a star
-- function starFunc(value, position, rotation)

-- end
