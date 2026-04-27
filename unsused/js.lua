-- jump state monitor






onPostUpdate = function()
    state = get("Player.jumpState")
    echo(tostring(state))

end