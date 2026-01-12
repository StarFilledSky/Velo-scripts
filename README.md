## this is a my collection of QOL velo mod scripts for speedrunners

i would always highly recommend vetting any scripts for velo before you use them. while there's no sandboxing and scripts can access beyond the game.


### adding to your game
drop scripts into the Speedrunners/Velo/scripts folder

### running velo scripts:
taken from velo documentation

>You can open up the console by pressing CTRL+Z. In order to change this hotkey, press F1 and change it under "Console" -> "enabled". Having opened up the console, you can now start typing commands by pressing ENTER and execute them by pressing ENTER again. Type `help` to get a list of commands and `helpAll` to get a complete list of all commands, which includes a lot of more niche commands only useful for Lua scripts. Command names are not case-sensitive, so `helpall` would work, too.

to run scripts you've added to the script folder just type the name without .lua at the end
dstart for example

### script descriptions

### dstart
offers ways to reset a solo run with delays
- hotkey
- on new lap
- on stun


### Surf
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