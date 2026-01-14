-- constantly removes any items you pickup
-- nice for removing items if you have a trigger finger but it invalidates velo runs :(


onPostUpdate = function()
    if not get("Velo.isIngame") or get("Velo.isOnline") then
        return;
    end
    
    i = get("Player.itemId")
    if i ~= 0 then
        set("Player.itemId", "0")
    end
end
