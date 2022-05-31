local speed = 35

getgenv().set_speed = function(amount)
    speed = amount
end

local default_setspeed = localplayer.setbasewalkspeed

localplayer.setbasewalkspeed = function(lp, amount)
    if config.character.walkspeed then
        amount = speed
    end
    default_setspeed(localplayer, amount)
end