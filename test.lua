-- @author sky!!
--
--
-- animation test
-- goal: i want to have keys and interpolate between them
-- if the value is the same and it's linear do nothing
-- i don't want to deal with any special cases, just number interpolation
--
-- my keyframes and the animobj kinda seem interchangable
-- i want animobj to be the state keeper for object and keyframes are the values it blends between
-- keyframes seem like kind of a waste if you only need to change certain values
-- 


local AnimObjState = {}
local Track = {}
local Timeline = {}

-- Vector2, Vector2, float, _visibility:boolean
function AnimObjState:new(_position, _scale, _rotation, _visibility)
    local obj = {}
    local track = {{}, {}, {}}
    setmetatable(obj, AnimObjState)
    self.position = _position or Vector2:new(0, 0)
    self.scale = _scale or  Vector2:new(0, 0)
    self.rotation = _rotation or 0.0
    self.visibility = _visibility or true
    return obj
end

-- AnimObjState, {Keyframes} optional
function Track:new(_focus, _keyframes)
    local obj = {}
    setmetatable(obj, Track)

    self.focus = _focus
    self.keyframes = _keyframes or {}

    return obj


end

function Track:update(t)

end

function Timeline:new()
    local obj = {}
    setmetatable(obj, Timeline)

    self.tracks = {}
    self.trackPosition = 0

    return obj
end

local width = get("Velo.screenWidth")
local height = get("Velo.screenHeight")

local tl = Timeline:new()
local rect = AnimObjState:new(Vector2:new(0, 0),
Vector2:new(width, height),
0,
true)
local keyframes = {}



table.insert(tl.tracks, )


-- the issue with this is that there's not really an orginization, no way besides iterating over everything to get the next value if there is one
-- keyframe_insert(obj.rotation, 360)

-----------------------------------------------------------------------------

-- animtest

-- local hotkey = 0x42 -- b

-- local queue = {}

-- local starPoints = {}
-- local theta = 0 -- angle start
-- local thetaRotation = 1
-- local toMillis = (10^7) 

-- local xSpacing = 100
-- local ySpacing = 100

-- local Clip = {}
-- function Clip:new(length, anims)
--     local obj = {}
--     setmetatable(obj, Clip)
--     obj.deltaSec = 0
--     obj.position = 0
--     obj.length = length
--     obj.anims = anims
--     return obj
-- end

-- function inputPoll()

-- end

-- function update()
--     if isReleased(hotkey) then -- on press initialize the reset

--     end

--     local time = get("Velo.deltaSec")
--     -- theta = theta + (time)

--     local tmp = 0

--     starPoints = {}

--     for i = 1, 3, 1 do

--         local x = math.cos(tmp)
--         local y = math.sin(tmp)

--         -- local p1 = 
--         -- local p2 = 
--         -- local p3 = 

--         tmp = tmp + 90
--     end

--     -- for i = 1, 12, 1 do
--     --     local x = math.cos(tmp) * xSpacing
--     --     local y = math.sin(tmp) * ySpacing
--     --     local p = Vector2:new(x, y)
--     --     -- local p = Vector2:new(i * xOffset, math.sin(theta % loop * i) * yOffset)
--     --     table.insert(starPoints, p)
--     --     tmp = tmp + thetaRotation
--     -- end

-- end

-- function render()

--     drawStar()

-- end

-- function drawStar()
--     local offset = Vector2:new(800, 600)
--     -- echo(tostring(starPoints[1]*offset))
--     for i = 1, #starPoints - 1 do
--         local val = (255 / #starPoints) * i - 1

--         local c = Color:new(val,val,val)
--         drawLine(vecA(starPoints[i], offset), vecA(starPoints[i+1], offset), 2, c)

--         -- drawLine(starPoints[i], starPoints[i+1], 5, c)
--     end
-- end

-- function vecA(vec1, vec2)
--     return Vector2:new(vec1.x + vec2.x, vec1.y + vec2.y)
-- end

-- function vecM(vec1, vec2)
--     return Vector2:new(vec1.x * vec2.x, vec1.y * vec2.y)
-- end
-- update()
-- render()
-- drawStar()
-- onPostUpdate = update
-- onPostDraw = render

---------------------------------------------------------------------------
--[[
create a bunch of ghosts, position them according to where the player released grapples

--]]

-- onPostUpdate = function()
--     player = "Player"
--     sprite_pos = get(player .. ".sprite.position")
--     echo(tostring(sprite_pos.x) .. " : " .. tostring(sprite_pos.y))
-- set(player .. ".sprite.position", Vector2:new(200,200))
-- echo(tostring(sprite_pos.width) .. " : " .. tostring(sprite_pos.height))

-- set(player .. ".sprite.currentFrameInAnimation", 2)
-- end

-- for i = 1, 35, 1 do
--     prepareGhost(i - 1, 3)
-- end

-- for i = 1, 35, 1 do
--     player = "Player#".. tostring(i-1)
--     posx = get(player .. ".actor.position.x")
--     if posx == nil then
--         echo("ended at index " .. tostring(i))
--         exit()
--     end
--     set(player .. ".actor.position.x", posx + ((i-1)*5))

--     set(player .. ".sprite.", )

-- set(player .. ".badConnectionImage.isVisible", true)
-- set(player .. ".badConnectionImage.opacity", 1) -- didn't work
-- set(player .. ".badConnectionImage.position.x ", get(player .. ".actor.position.x")) -- didn't work
-- set(player .. ".badConnectionImage.position.y ", get(player .. ".actor.position.y")) -- didn't work
-- 

-- end

-----------------------------------------------------------------

-- local success, util = pcall(require, "Velo\\scripts\\skyutil")
-- if not success then
--     echo("Module failed to load: " .. util)
--     return
-- end

-- data = ""

-- onPostUpdate = function()
--     if not get("Velo.inGame") then
--         data = ""
--         return
--     end

--     data = tostring("Player.jumpTime: " .. get("Player.jumpTime"))

-- end

-- onPostDraw = function()
--     util.draw_logs(data)
-- end

-----------------------------------------------------------------

-- only works when velo ui is up :(
-- a = getSt("UI.disable key input")
-- echo(tostring(a))

-- onPostUpdate = function()

-- end

-----------------------------------------------------------------

-- this was a pb diff shower

-- local success, util = pcall(require, "Velo\\scripts\\skyutil")
-- if not success then
--     echo("Module failed to load: " .. util)
--     return
-- end

-- onLapFinish = function(time)

--     local user_id = get("Velo.mySteamId")
--     local map_id = get("Velo.mapId")
--     local pbrun = await(requestPlayerPBRun(user_id, map_id, 0))[1] -- do NOT call a variable run dumbfuck

--     savelast("tmp")
--         -- local lastrun = 

--     -- for k, v in pairs(run) do
--         --     echo("key: " .. k .. " val: " .. tostring(v))
--         -- end
--         -- echo(tostring(run.runTime - (time * 1000)))
--     local diff = pbrun.runTime - (time * 1000)
--     run("timed_msg", 5, tostring(diff))

--     -- echo("Aaa")

-- end

-- local user_id = get("Velo.mySteamId")
-- local map_id = get("Velo.mapId")
-- local run = await(requestPlayerPBRun(user_id, map_id, 0))
-- echo(tostring(run))
-- echo(tostring(type(run)))

-- IT DOESN'T WORK ???

-- echo(tostring(user_id))
-- echo(tostring(runid[1]))

-- download(run_id[1], "_temp" .. tostring(i))
-- local b = await(requestRun(runid[1]))
-- echo("pb: " .. tostring(a["runtime"]))
-- -- echo("last run " .. tostring(time))
-- echo(type(b))
-- for k, v in pairs(run[1]) do
--     echo("key: " .. k .. " val: " .. tostring(v))
-- end

-- onLapFinish = function(time)
--     run("timed_msg", 5, "wahhh")

-- end

--     local user_id = get("Velo.mySteamId")
--     local map_id = get("Velo.mapId")
--     local a = requestPlayerPBRuns(user_id, map_id, 0) -- hardcoded type idc
--     for _, v in pairs(a) do
--         echo(type(a))
--     end
--     run("timed_msg", 5, "wahhh")

-- end

-----------------------------------------------------------------

-- util drawlogs test

-- local peak = 0
-- onPostDraw = function()
--     local v = -get("Player.actor.velocity").y
--     if v > peak or v < -400 then
--         peak = v
--     end
--     local a = string.format("%0.00f", v)
--     util.draw_logs(a .. "\n" .. peak)

-- end

--------------------------------------------------------------------------------------------------------
-- rocket detection test

-- onPostUpdate = function()
--     for i = 0, 10 do
--         r = set("Rocket#" .. tostring(i) .. ".isExploded", true)
--         r = get("Rocket#" .. tostring(i) .. ".isExploded")
--         echo("rocket#" .. tostring(i) .. " exploded:" .. tostring(r))

-- if r and type(r) == "boolean" then
--     echo("rocket#" .. tostring(i) .. " exploded" .. tostring(r))

-- end
--     end

-- end

-------------------------------------------------------------------
-- onPostUpdate = function() -- 2 missles show up for the player, 3 for ghost, all x y are all 0 when shooting missles
--     for i = 1, 10 do
--     pos = get("Rocket#".. tostring(i) .. ".actor.position")
--     echo(tostring(i) .. ": " .. tostring(pos.x) .. " " .. tostring(pos.y))
--     end
-- end
-- -----------------------------------------------------------------
-- onPostUpdate = function()  -- always returns false and doesn't increase
--     for i = 0, 10 do
--         r = get("Rocket#" .. tostring(i) .. ".isExploded")
--         echo("rocket#" .. tostring(i) .. " explode status:" .. tostring(r))
--     end
-- end
-- -----------------------------------------------------------------
-- onPostUpdate = function() -- doesn't change value when shooting missles
--     a = count("Rocket")
--     echo("amnt: " .. tostring(a))
-- end
-- -----------------------------------------------------------------
-- onPostUpdate = function() -- returns a string "Rocket#[#] x y"
--     a = locate("Rocket")
--     for _, v in pairs(a) do
--         echo(tostring(v))
--     end
-- end
--------------------------------------------------------------------
-- local int_max = -2147483648 -- default value of stunnedById
-- local last_num = int_max
-- -- no idea what id this is for ngl
-- onPostUpdate = function() -- stunnedById returns a number in the hundreds or thousands, only changes if there's multiple missles 
--     a = get("Player.stunnedById")

--     if type(a) == "number" and a ~= int_max and a ~= last_num then
--         last_num = a
--         m = get("Rocket#" .. tostring(a).. ".isExploded") -- just returns a table with the query

--         echo("a:" .. tostring(a))
--         echo(tostring(m[1]))
--     end
-- end
--------------------------------------------------------------------
-- onPostUpdate = function() -- all missles always reads as false or are just a table with the query
--     for i = 0, 10 do
--         m = get("Rocket#" .. tostring(i).. ".isExploded")
--         echo(tostring(m))
--     end
-- end
---------------------------------------------------------------------

-- onPostUpdate = function() -- always returns 3
--     echo(tostring(get("Player.rockets.count"))) 
-- end

--------------------------------------------------------------------------------------------------------

-- tas ui 
-- take 2

--[[
4 classes
element maybe?
 -  a button is just an element with mouse specific actions and it might help break it up into more manageable chunks
element style
text style
text
button

]]

-- local Element = {}
-- local Text = {}
-- local TextStyle = {}
-- local Button = {}
-- local ButtonStyle = {}

-- function Element:new(type, position, bounds, padding, scale, rotation, background_color)
--     local e = {}

--     e.type = type or nil
--     e.position = position or Vector2:new(0, 0)
--     e.bounds = bounds or Vector2:new(0, 0)
--     e.padding = padding or {0, 0, 0, 0} -- x1, y1, x2, y2
--     e.scale = scale or 1
--     e.rotation = rotation or 0
--     e.background_color = background_color or Color:new(0, 0, 0)
--     e.children = {}

--     function e:getCenteredPosition()
--         adjusted = Vector2:new(self.position.x, self.position.y)
--         offset = self.bounds / 2
--         adjusted = adjusted - offset
--         return adjusted 
--     end

--     return e
-- end
-- --[[i skip these for now i think
-- layout
--     - childgap // margin?
-- border
-- drop shadow
-- ]]

-- function TextStyle:new(font, font_size, drop_shadow, container_alignment, color)
--     local s = {}

--     s.font = font or "UI\\Font\\sky\\UbuntuNerdFont-Regular.ttf"
--     s.font_size = font_size or 25
--     s.drop_shadow = drop_shadow or true
--     s.container_alignment = container_alignment or Vector2:new(0.5, 0.5)
--     s.color = color or Color:new(0, 0, 0)

--     return s
-- end

-- function Text:new(element, content, style)
--     local t = {}
--     t.element = element or Element:new()
--     t.content = content or ""
--     t.style = style or TextStyle:new()

--     function t:calcuateBounds()
--         self.element.bounds = measureText(self.content, self.style.font, self.style.font_size)
--         return 
--     end

--     t:calcuateBounds()
--     return t
-- end

-- -- fuck adding drop shadow, problem for another time
-- function ElementStyle:new(color)

--     local bs = {}
--     bs.color = color

--     return bs
-- end

-- function Button:new(element, text, style)
--     local b = {}

--     b.element = element or Element:new()
--     b.text = text or Text:new("")
--     b.style = style or ElementStyle:new()
--     b.children = {}

--     return b
-- end

-- function UpdateElement()

-- end

-- function RenderElement()

-- end

-- b_style_default = ElementStyle()
-- b_style_default.color = rgb(121, 98, 158)
-- b_style_hover = ElementStyle()
-- b_style_hover.color = rgb(219, 205, 241)
-- b_style_clicked = ElementStyle()
-- b_style_clicked.color = rgb(141, 212, 251)

-- toggle_tas = Button(Element:new(Vector2:new(500, 600)), "Togggle TAS mode")
-- toggle_tas.onClick = function()
--     in_tas_mode = getSt("Offline Game Mods.TAS.TAS editor.enabled")
--     t = Toggle:new(in_tas_mode.key, not in_tas_mode.enabled)

--     setSt("Offline Game Mods.TAS.TAS editor.enabled", t)
-- end

-- _______________________________________________________________________________________________________________________

-- --[[
-- command: #
-- will index folders for scripts
-- command: # [scriptname]
-- will run the script
-- ]]

-- -- # a velo shell
-- -- directories = ['.', "unused", ]
-- -- echo("# shell")
-- local success, util = pcall(require, "Velo\\scripts\\skyutil")
-- if not success then
--     print("Module failed to load: " .. util)
--     return
-- end

-- dir = "velo\\scripts"
-- local handle = io.popen("dir /B /S " .. dir) -- barebones and subdirectories
-- local result = handle:read("*a")
-- handle:close()

-- test = util.split(result, "\n")

-- for _, line in ipairs(test) do
--     filelink = util.split(line, "\\")
--     if #filelink > 1 then
--         file_path_arr = {table.unpack(filelink, 1, #filelink-1)}
--         file_name = filelink[#filelink]
--         file_path = util.join(file_path_arr, "\\")
--         -- echo("a" .. file_path)

--         if string.gmatch(file_name, ".lua$") then
--             echo("script: " .. file_name)
--         end
--     end
-- end

-- function listDirectory(directory)
--     local handle = io.popen("dir /B /S " .. directory) -- barebones and subdirectories
--     local result = handle:read("*a")
--     handle:close()

--     -- error checks
--     if result == "The system cannot find the path specified." then

--         echo("urhm couldn't find that directory,,,")
--     end

-- end

-- function getScripts(directory)
--     directory = directory or ""
--     local handle = io.popen("dir /B /S " .. directory) -- barebones and subdirectories
-- local result = handle:read("*a")
-- handle:close()

-- end
-- -- onPostUpdate = function()
-- --     entry = tostring(await(readLine()))
-- --     echo("input: " .. entry)

-- --     if string.lower(entry) == "exit" then
-- --         exit()
-- --     end
-- -- end

