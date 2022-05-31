local jump_power = 35

local default_jump = localplayer.jump

getgenv().set_jump_power = function(amount)
    jump_power = amount
end

localplayer.jump = function(s, amount)
    if config.character.jumppower then
        amount = jump_power
    end
    return default_jump(s, amount)
end