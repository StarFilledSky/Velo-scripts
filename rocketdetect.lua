-- @author sky!!
-- @description: awful awful code
-- @velofields
-- Rocket.actor.id
-- 
-- Player.stunnedById
-- By default this value sits at -2147483648, The negative max value of a long I think. 
-- When stunned, it gives the actor id of what stuned the player and we can compare this to the objects in the game as they all count/have actors. 
-- If there's no player it just returns a table.
-- 
--
local rocketIds = {}
-- 4 players and getting the id's of the 3 prefabs or something assigned to them.
-- the amount only increases if the player somehow exceeds 3 active rocket so it's a pretty safe bet to not check for more.
-- if there was a need I think you could use Player.rockets to get a list of names for rockets that belong to players as a one of scan.
local scanRange = 4 * 3

-- get rocket ids into an array so that when the player is stunned we can compare them without overhead
function scanRockets()
    rocketIds = {}

    for i = 0, scanRange, 1 do
        local rocket = "Rocket#" .. tostring(i)
        local id = get(rocket .. ".actor.id")

        if type(id) ~= "table" then
            local index = #rocketIds + 1
            rocketIds[index] = {}
            rocketIds[index]["actorId"] = id
            rocketIds[index]["name"] = rocket
            rocketIds[index]["eventTriggered"] = false
            rocketIds[index]["stunnedPlayer"] = ""
        end

    end

end

function update()

    local stunnedPlayer = false
    local stunnedByRocket = false
    local stunnedIds = {}
    local stunnedPlayers = {}

    -- check if any players are stunned and put the id of the actor that stunned them into stunnedIds
    for i = 0, 3, 1 do

        local player = "Player#" .. tostring(i)
        -- This is sometimes nil, I think if it's at an index of 5 or maybe when it's out of bounds of the amount of players in game.
        -- I only tested with bots and they have different names than "Player" sometimes so might be related to that. Not looking into it.
        local stunId = get(player .. ".stunnedById")

        if type(stunId) ~= "table" and stunId ~= nil then
            if stunId > 0 then
                stunnedPlayer = true
                local data = {}
                data["player"] = player
                data["stunId"] = stunId
                table.insert(stunnedIds, data)
            end
        end
    end

    -- reset rocket events if no stunned players
    -- need a better way to keep track of when rockets need to be reset but I'm not super invested in this script
    -- if player1 was stunned and then player2 got stunned while player1 is stunned, 
    -- this wouldn't fire an event for player1 getting stunned
    -- while player2 is still stunned because of the overlapping triggers. rarer case but still
    if not stunnedPlayer then
        for i = 1, #rocketIds, 1 do
            rocketIds[i]["eventTriggered"] = false
            rocketIds[i]["stunnedPlayer"] = ""
        end
    end

    -- -- check if any player was stunned by a rocket
    if stunnedPlayer then
        for x = 1, #stunnedIds, 1 do
            for y = 1, #rocketIds, 1 do
                if stunnedIds[x]["stunId"] == rocketIds[y]["actorId"] and not rocketIds[y]["eventTriggered"] then

                    rocketIds[y]["eventTriggered"] = true
                    rocketIds[y]["stunnedPlayer"] = stunnedIds[x]["player"]

                    stunnedByRocket = true
                end
            end
        end
    end
    
    -- if there is any player stunned by a rocket..
    -- doesn't account for toggling off while waiting
    if stunnedByRocket then
        -- rocket event stuff
        
        -- prep data for impact frame
        for i = 1, #rocketIds, 1 do
            -- echo(tostring((rocketIds[i]["eventTriggered"])))
            -- if rocketIds[i]["eventTriggered"] then
                -- local index = #starData + 1
                -- starData[index]["playerPos"] = get(rocketIds[i]["stunnedPlayer"] .. ".actor.position")
                -- starData[index]["playerVel"] = get(rocketIds[i]["stunnedPlayer"] .. ".actor.velocity")
            -- end


        end

        -- onPostDraw = impact
        playSound("Audio\\Sfx\\Weapons\\ch_freeze.xnb", 10, 0, 0)
    end
end

-- about to write some god awful code here
local impactTimer = 0
local impactStep2 = 0.15
local impactStep3 = 2
local impactEnding = 1

local starData = {} -- when players get hit stars appear at their location

local width = get("Velo.screenWidth")
local height = get("Velo.screenHeight")

local screenCoverPos = Vector2:new(0, 0)
local screenCoverSize = Vector2:new(width, height)

function renderIdle()

end


function impact()
    -- echo(tostring(impactTimer))

    if impactTimer >= impactEnding then
        impactTimer = 0
        onPostDraw = renderIdle
        return
    end

    impactTimer = impactTimer + get("Velo.deltaSec")
    if impactTimer <= impactStep2 then
        drawRect(screenCoverPos, screenCoverSize, Color:new(255, 255, 255))

    elseif impactTimer <= impactStep3 then
        drawRect(screenCoverPos, screenCoverSize, Color:new(0, 0, 0))

        for star in starData do
            local offset = 10
            local x1 = star["playerPos"].x
            local y1 = star["playerPos"].y
            local x2  = star["playerPos"].x
            local y2  = star["playerPos"].y
            
            drawRect(Vector2:new(x1, y1), Vector2:new(x2,y2), Color:new(255, 255, 255))
        end

    elseif impactTimer <= impactEnding then

    end

end

scanRockets()
onPostUpdate = update
onPostdraw = renderIdle
