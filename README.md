## This is my collection of scripts for Velo mod for Speedrunners

> [!IMPORTANT]
> I would always highly recommend vetting any scripts for velo before you use them.
> They aren't isolated and the possibility of a script executing malicous code does exist.

## Adding to your game
Drop scripts into the Speedrunners/Velo/scripts folder

## Running velo scripts:
Taken from Velo documentation found [here](https://github.com/rbit-sr/Lua-Guide/blob/main/_Lua%20guide.md) and also comes with the Velo install as _Lua guide.md in the main Speedrunners folder.





>You can open up the console by pressing CTRL+Z. In order to change this hotkey, press F1 and change it under "Console" -> "enabled". Having opened up the console, you can now start typing commands by pressing ENTER and execute them by pressing ENTER again. Type `help` to get a list of commands and `helpAll` to get a complete list of all commands, which includes a lot of more niche commands only useful for Lua scripts. Command names are not case-sensitive, so `helpall` would work, too.

To run scripts you've added to the script folder just type the name without .lua at the end
dstart for example

## Stopping velo scripts
Taken from velo documentation

>You can stop a script using the `stop [name]` command and restart it using `restart [name]`, which will pass the same initial parameters to the script again. Furthermore, you can call `exit()` inside a script to stop it (do not use `stop` on itself!). Note that `exit()` will not immediately exit the script but only on the next update. You may imagine it being more of a "request stop" function. You can get a list of all currently running scripts via `listRunning`.


## Scripts

### cg.lua
Uses `clearcghosts` on player reset(reset button or lap completion) to keep ghosts from appearing.  
<video src="https://github.com/user-attachments/assets/230886a7-779d-4de9-acaf-40ed2424ce46" autoplay loop muted width="400" height="225"></video>  
<video src="https://github.com/user-attachments/assets/7cc8314a-ed46-4b59-a416-4f6a395639a4" autoplay loop muted width="400" height="225"></video>  


### fastload.lua
Skips the countdown when entering a stage solo, I'd recommend adding it to the onStart for convenience.  
<video src="https://github.com/user-attachments/assets/8d899569-0482-419c-9aa0-6f27e8e3c72a" autoplay loop muted width="400" height="225"></video>  


### timed_msg.lua
Shows a message in the top right for a specified amount of time. Trigger it from a script by using:  
``run("timed_msg", 5, "This is my amazing message")``  
<video src="https://github.com/user-attachments/assets/acfe94f2-d206-49d2-a533-27dc75c7568b" autoplay loop muted width="400" height="225"></video>  






### dstart
offers ways to reset a solo run with delays
- hotkey
- on new lap
- on stun
<video src="https://github.com/user-attachments/assets/1ba4faeb-7f49-4209-bd66-93589a88afb0" autoplay loop muted width="400" height="225"></video>  

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

it offers 4 booleans for getting the status

- surf_started
- surfing
- surf_ended
- oversurfed

### surf example

this is an example file that plays a sound at the start of a slope surf and draws a line at the latest slope surf. requires Surf.lua.

### fade

a shitpost program that makes the game harder. your screen darkens anytime you use your boost. pretty sure it's not framerate independent so you may need to play with the variables to achieve proper levels of suffering.


### PB

a script for retrieving your latest new lap pb on a map and making it the ghost. doesn't entirely work for club V. don't know why leaderboards is like that for that map.

### fps

drops your fps to 60 when not in game and to 300 when in game
would suggest adding this line to the onStart.lua file in the scripts folder to have it run from when you start speedrunners
`run("fps")`
the onStart file gets wiped on every velo update so you'll have to readd the line.

### lt

a program for getting all the targets and putting it into a tree and writing it to a file. by default it writes the to speedrunners/targetlist.txt.
todo use this for making documentation


depth 1 contains targets and any unique field(subtargets) with subfields like actor
depth 2 has any fields that belong to the targets or subtargets

actor for example is a field with a subfield so it would show up like
root
    Player: target
        actor: CActor
        airtime: int
        badConnectionImage: somethingsomething
        ...
    CActor: subtarget
        velocity: Vector2
        id: int
        ...

i move all the subtargets to the depth of 1 to avoid duplicates that would exponentially explode the node tree size if i just recursively added fields
