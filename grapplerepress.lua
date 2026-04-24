-- @encoding utf-8
-- @author sky!!
-- @description: This measures the amount of time between when a swing is released
-- And the player presses the grapple button again. If grapple is pressed before
-- the cooldown is over it displays a negative number for the time until cooldown.
--
-- @rambling: I wondered about optimizing grapple presses but I wasn't able to make
-- much sense/use of the data. Maybe it would be useful when tied to something else.


-- @TODO make a version for replays



local pos = Vector2:new(0, 0)
local bounds = Vector2:new(get("Velo.screenWidth"), get("Velo.screenHeight"))
local scale = 1
local rotation = 0
local font = "Content\\UI\\Font\\NotoSans-Regular.ttf"
local fs = 40
local ds = true


-- just give alignment for screen in decibles like 0.5 0.5 for center
function draw_logs(text, alignment_x, alignment_y, col)
    local alignment = Vector2:new(alignment_x or 0.8, alignment_y or 0.15)
    local c = col or Color:new(255, 255, 255)

    drawText(
    text or ""
    ,pos
    ,bounds
    ,alignment
    ,scale
    ,rotation
    ,font
    ,fs
    ,ds
    ,c)

end

local toMillis = (10^7) 
local currentReleaseTime = 0
local lastReleaseTime = 0
local repressTime = 0
local repressVal = 0
local wasSwinging = false
local wasHolding = false
local checkingCutoff = 2 * toMillis -- when the gap is so big the data probably doesn't matter, resets if larger
local previousCooldown = 0

function dormant()
    if get("Velo.isIngame") then
        onPostUpdate = active
        onPostDraw = draw
        return
    end
end

function active()
    -- reset variables and switch to dormant mode when not in game
    if not get("Velo.isIngame") then
        repressTime = 0
        currentReleaseTime = 0
        repressVal = 0.0
        wasSwinging = false

        onPostUpdate = dormant
        onPostDraw = nodraw
        return
    end

    -- this sucks for watching replays on slowed down time
    -- i think the velo jump holding display also suffers from not accounting for slowdown
    -- todo find a better solution 
    -- local time = get("Velo.realTime")
    local time = get("Velo.totalTime")
    
    local isSwinging = get("Player.isSwinging")
    local isHolding = get("Player.grappleHeld")
    local currentCooldown = get("Player._grappleCooldown")
    
    local released = wasSwinging and not isSwinging
    local repressed = isHolding and not wasHolding

    if released then
        currentReleaseTime = time
    end
    
    if repressed and lastReleaseTime ~= currentReleaseTime then
        if time - currentReleaseTime < checkingCutoff then
            lastReleaseTime = currentReleaseTime
            repressVal = ((time - currentReleaseTime) / toMillis) - previousCooldown
        else
            repressVal = 0
        end

         
    end
    
    previousCooldown = currentCooldown
    wasSwinging = isSwinging
    wasHolding = isHolding
end


function nodraw()

end

function draw()
    draw_logs(string.format("%1.3f", repressVal))
end



onPostUpdate = active
onPostDraw = draw
