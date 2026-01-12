this is a my collection of QOL velo mod scripts for speedrunners

would always highly recommend vetting any scripts for velo before you use them. while there's no sandboxing and scripts can access beyond the game.

dstart
offers ways to reset a solo run with delays
- hotkey
- on new lap
- on stun


Surf
a library for detecting is a player is slope surfing

you can include it in your project with
local Surf = require("Velo\\scripts\\Surf")

i would recommend this for the error checking

local success, Surf = pcall(require, "Velo\\scripts\\Surf")
if not success then
    echo("Module failed to load: " .. Surf)
end

you can initialize it with

s = Surf:new([0-4?])

and add s:update() to onPostUpdate or whatever update function you're using

it offers 3 booleans for getting the status

surf_started
surfing
surf_ended