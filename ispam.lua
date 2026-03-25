-- item spam
-- gives you unlimited amounts of an item all the time for testing purposes

usage = "usage: " ..
arg[0] .. " [item_id]\n"..
"you can use listItems to view the id's"

item_id = arg[1]
echo(tostring(item_id))
if #arg < 1 or type(item_id) ~= "number" or item_id > 17 or item_id < 0 then
    echo(usage)
    return
end

onPostUpdate = function()

    set("Player.itemId", item_id)

end