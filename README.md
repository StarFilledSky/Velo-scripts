## this is a my collection of QOL velo mod scripts for speedrunners

i would always highly recommend vetting any scripts for velo before you use them. there's no sandboxing and scripts can easily access beyond the game.


## adding to your game
drop scripts into the Speedrunners/Velo/scripts folder

## running velo scripts:
taken from velo documentation

>You can open up the console by pressing CTRL+Z. In order to change this hotkey, press F1 and change it under "Console" -> "enabled". Having opened up the console, you can now start typing commands by pressing ENTER and execute them by pressing ENTER again. Type `help` to get a list of commands and `helpAll` to get a complete list of all commands, which includes a lot of more niche commands only useful for Lua scripts. Command names are not case-sensitive, so `helpall` would work, too.

to run scripts you've added to the script folder just type the name without .lua at the end
dstart for example

## stopping velo scripts
taken from velo documentation

>You can stop a script using the `stop [name]` command and restart it using `restart [name]`, which will pass the same initial parameters to the script again. Furthermore, you can call `exit()` inside a script to stop it (do not use `stop` on itself!). Note that `exit()` will not immediately exit the script but only on the next update. You may imagine it being more of a "request stop" function. You can get a list of all currently running scripts via `listRunning`.


## script descriptions

### dstart
offers ways to reset a solo run with delays
- hotkey
- on new lap
- on stun

you can enable or disable the methods you want by changing between true and false

- restart_on_hotkey
- restart_on_lap
- restart_on_stun

you can also change the default hotkey (b) by replacing the [keycode](https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes)


### Surf
a library for detecting is a player is slope surfing

you can include it in your project with `local Surf = require("Velo\\scripts\\Surf")`

i would recommend this for the error checking
```lua
local success, Surf = pcall(require, "Velo\\scripts\\Surf")
if not success then
    echo("Module failed to load: " .. Surf)
end
```
you can initialize it with `s = Surf:new([player number?])` and add `s:update()` to `onPostUpdate` or whatever update function you're using

it offers 3 booleans for getting the status

- surf_started
- surfing
- surf_ended

### surf example

this is an example file that plays a sound at the start of a slope surf and draws a line at the latest slope surf. requires Surf.lua.

### fade

a shitpost program that makes the game harder. your screen darkens anytime you use your boost. pretty sure it's not framerate independent so you may need to play with the variables to achieve proper levels of suffering.


### PB

a script for retrieving your latest new lap pb on a map and making it the ghost. doesn't entirely work for club V. don't know why leaderboards is like that for that map.