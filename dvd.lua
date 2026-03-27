-- dvd
-- blocks out the viewport expect for a small window that bounces around the screen
-- goes away when dead




local width = get("Velo.screenWidth")
local height = get("Velo.screenHeight")


-- variables the user can mess with
local apsect_ratio = 9 / 16
local window_width = 1200
local window_height = window_width * apsect_ratio
local speed = 100
local c = Color:new(0,0,0)


local position = Vector2:new(math.floor(width / 2), math.floor(height / 2))
local direction = Vector2:new(speed * ((math.random(0, 1) * 2) - 1), speed * ((math.random(0, 1) * 2) - 1)) -- speed * (positive|negative 1)

local should_draw = true

-- order top left, top right, bottom right, bottom left
local verts = {
    a_outer = Vector2:new(0, 0),
    b_outer = Vector2:new(width + 1, 0),
    c_outer = Vector2:new(width + 1, height + 1),
    d_outer = Vector2:new(0, height + 1),

    a_inner = Vector2:new(0, 0),
    b_inner = Vector2:new(0, 0),
    c_inner = Vector2:new(0, 0),
    d_inner = Vector2:new(0, 0),
}


onPostUpdate = function()
    
    -- a really jank check to see if the player is alive in multiplayer
    -- haven't found a better check than isCollsiionActive, not sure if there's false positives
    -- isStillAlive doesn't change value
    if not get("Velo.isIngame") or not get("Player.actor.isCollisionActive") then 
        should_draw = false
        return;
    else
        should_draw = true
    end

    local dt = get("Velo.deltaSec")
    local dt_vec = Vector2:new(dt, dt)
    local check = position + (direction * dt_vec) -- projection position to see if it would hit a wall

    verts.a_inner = check - Vector2:new(math.floor(window_width / 2), math.floor(window_height / 2))
    verts.b_inner = check - Vector2:new(-math.floor(window_width / 2), math.floor(window_height / 2))
    verts.c_inner = check - Vector2:new(-math.floor(window_width / 2), -math.floor(window_height / 2))
    verts.d_inner = check - Vector2:new(math.floor(window_width / 2), -math.floor(window_height / 2))
    
    -- invert direction if hitting a y wall
    if verts.a_inner.x < 0 or verts.b_inner.x > width then direction.x = direction.x * -1 end
    -- invert direction if hitting a y wall
    if verts.a_inner.y < 0 or verts.d_inner.y > height then direction.y = direction.y * -1 end

    position = position + (direction * dt_vec)

    verts.a_inner = position - Vector2:new(math.floor(window_width / 2), math.floor(window_height / 2))
    verts.b_inner = position - Vector2:new(-math.floor(window_width / 2), math.floor(window_height / 2))
    verts.c_inner = position - Vector2:new(-math.floor(window_width / 2), -math.floor(window_height / 2))
    verts.d_inner = position - Vector2:new(math.floor(window_width / 2), -math.floor(window_height / 2))

end

onPostDrawLayer = function(layer)

    if layer ~= "TrailInFrontOfLocalPlayersLayer" or not should_draw then
        return
    end

local v = {
    verts.a_outer,
    verts.a_inner,
    verts.b_inner,

    verts.b_inner,
    verts.a_outer,
    verts.b_outer,

    verts.b_outer,
    verts.b_inner,
    verts.c_inner,
    
    verts.c_inner,
    verts.b_outer,
    verts.c_outer,

    verts.c_outer,
    verts.c_inner,
    verts.d_inner,
    
    verts.d_inner,
    verts.c_outer,
    verts.d_outer,

    verts.d_outer,
    verts.d_inner,
    verts.a_inner,
    
    verts.a_inner,
    verts.d_outer,
    verts.a_outer,
}

drawTriangles(v, c)

end