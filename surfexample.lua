local success, Surf = pcall(require, "Velo\\scripts\\Surf")
if not success then
    echo("Module failed to load: " .. Surf)
end

local s = Surf:new()


 -- i think playsound starts in the content folder but it might also check other places idk
 -- can confirm wav/xnb files work, haven't/don't remember testing other file formats
local surf_start_audio = "Audio/Sfx/Weapons/ch_freeze.xnb"
local oversurf_audio = "Audio/Sfx/Weapons/item_rocket_launch_1.xnb"
local volume = 0.5
local pitch = 0


local surf_pos_start = get(s.player .. ".actor.position")
local surf_pos_end = get(s.player .. ".actor.position")

local horizontal_offset = Vector2:new(25, 0)
local vertical_offset = Vector2:new(0, 45)

onPostUpdate = function()
    s:update()
    if s.paused then
        return
    end
    
    if s.surf_started then
        playSound(surf_start_audio, volume, pitch, 0) -- remove this if you don't want sound
        offset = vertical_offset

        if get(s.player .. ".moveDirection") == 1 then
            offset = offset + horizontal_offset
        end
        
        surf_pos_start = get(s.player .. ".actor.position") + offset
        surf_pos_end = get(s.player .. ".actor.position") + offset

    end

    if s.surfing then

        offset = vertical_offset
        
        if get(s.player .. ".moveDirection") == 1 then
            offset = offset + horizontal_offset
        end
        
        surf_pos_end = get(s.player .. ".actor.position") + offset
        
    end

    if s.surf_ended then
        -- todo put something here maybe
    end

    if s.oversurfed then
        playSound(oversurf_audio, volume, pitch, 0) -- remove this if you don't want sound
    end

end

onPostDraw = function()

    drawLine(worldToScreen(surf_pos_start), worldToScreen(surf_pos_end), 3, Color:new(255, 0, 0))

end
