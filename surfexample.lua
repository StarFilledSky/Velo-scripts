local success, Surf = pcall(require, "Velo\\scripts\\Surf")
if not success then
    echo("Module failed to load: " .. Surf)
end

s = Surf:new()


 -- i think playsound starts in the content folder but it might also check other places idk
 -- can confirm wav/xnb files work, haven't/don't remember testing other file formats
audio = "Audio/Sfx/Weapons/ch_freeze.xnb"
volume = 0.5
pitch = 0


surf_start = get(s.player .. ".actor.position")
surf_end = get(s.player .. ".actor.position")

horizontal_offset = Vector2:new(25, 0)
vertical_offset = Vector2:new(0, 45)

onPostUpdate = function()
    s:update()
    
    if s.surf_started then
        playSound(audio, volume, pitch, 0) -- remove this if you don't want sound

        offset = vertical_offset

        if get(s.player .. ".moveDirection") == 1 then
            offset = offset + horizontal_offset
        end
        
        surf_start = get(s.player .. ".actor.position") + offset
        surf_end = get(s.player .. ".actor.position") + offset

    end

    if s.surfing then

        offset = vertical_offset
        
        if get(s.player .. ".moveDirection") == 1 then
            offset = offset + horizontal_offset
        end
        
        surf_end = get(s.player .. ".actor.position") + offset
        
    end

end

onPostDraw = function()


    drawLine(worldToScreen(surf_start), worldToScreen(surf_end), 3, Color:new(255, 0, 0))

end
