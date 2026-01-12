--[[

gets the players pb for the current map and sets it to a ghost

--]]


if not get("Velo.isIngame") or get("Velo.isOnline") then
    return;
end

local a = get("Player#1.name")

if type(a) ~= "string" then
    echo("making a ghost..ok?")
    prepareGhost(0)
end

local steamId = get("Velo.mySteamId")
local mapId = get("Velo.mapId")
-- requestId = nil -- todo uncomment this maybe and make it local
-- i feel like i might break something somehow and i don't care to check right now

-- the map ids for rws and officals are all below 200 or something
--this just selects
if mapId < 300 then 
    requestId = requestPlayerPBRuns(steamId, 0)
else
    requestId = requestPlayerPBRuns(steamId, 1)
end

onReceiveRuns = function(requestId_, runs)
    if requestId ~= requestId_ then return end
   
    echo("got the runs..ok?")
    
    mapPB = nil
    runtime = 999999
    echo(tostring(mapId))
    for k, v in pairs(runs) do

        if mapId == v.mapId and v.categoryId == NEW_LAP then
            
            if runtime  > v.runTime then
                
                mapPB = v
                runtime = v.runTime
            end
        end
    end

    if mapPB == nil then
        echo("no runs found for this map..ok?")
        exit()
    end

    download(mapPB.id, "run_"..tostring(mapPB.id))

end


onDownloadFinished = function(requestId_, id, name)
    -- if requestId ~= requestId_ then return end -- not working don't care enough to look into it

    echo("setting ghost..ok?")

    setGhost(name, 0)
    deleteRec(name)

    exit()
end