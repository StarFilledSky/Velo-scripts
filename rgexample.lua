--[[
rough rg detection example script based on convo with beanboy

i think the detection method he proposed was checking if the player was swinging left and afterwards going right
something abt this feels wrong but it works

no false positives that i observed

--]]




local was_swinging_left = false

onPostUpdate = function()

    if not get("Velo.isIngame") then
        return
    end


    grapple_dir = get("Player.grapple.direction.x")
    velocity = get("Player.actor.velocity.x")
    is_grapple_connected = get("Player.grapple.isConnected")
    -- using both jump held and vy because vy doesn't reset until you swing or touch ground or something
    -- inverted y because i hate jump being negative values
    jumping = get("Player.jumpHeld") and -get("Player.jumpVelocity.y") > 0
    
    rg = was_swinging_left and not is_grapple_connected and velocity > 0 and jumping

    if rg then 
        echo("rg")
        sound = "Audio/Sfx/Weapons/fireballHit.xnb"
        volume = 0.5
        pitch = 0

        playSound(sound, volume, pitch, 0)
    end


    was_swinging_left = is_grapple_connected and grapple_dir < 0
end