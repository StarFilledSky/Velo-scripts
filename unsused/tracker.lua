

local previous_actor_velocity = get("Player.actor.velocity")
local previous_position = get("Player.actor.position")

onPostUpdate = function()
    time = get("Velo.deltatime")
    current_actor_velocity = get("Player.actor.velocity")
    current_position = get("Player.actor.position")

    current_velocity = current_position - previous_position



    
    -- calculate actual velocity and compare it to actor velocity


end