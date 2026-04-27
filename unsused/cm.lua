-- attempt at a custom mode in level editor
-- i want to be able to free the camera and disable player input: 


-- despawn("Player")

local count = 0

-- cam = get("CCamera.position")
-- echo(tostring(cam.x))

onPostUpdate = function()
    var = "CCamera.view.M41"
    x = get(var)
    x = x + 1000
    set(var, x)
end

-- onPostUpdate = function()
--     var = "CCamera.view.M41"
--     x = get(var)
--     echo(tostring(x))
-- end
-- onPostUpdate = function()
--     -- var = "CCamera.viewport.viewport.x"
--     var = "SoloCameraModifier.offset.x"
--     c = get(var)
--     echo(c[1])
--     -- echo(tostring(c))
--     c = c + 1
--     set(var, c)
    
--     count = count + 1
    
--     if count > 10000 then
--         echo("bye!")
--         exit()
--     end

-- end

-- spawn("Player", Vector2:new(0,0))