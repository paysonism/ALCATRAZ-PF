local choke = {
    curr = 0,
    last_passed = {}
}

local old_send = network.send

function network.send(net, type, ...)
    if config.character.fake_lag then
        if type == "repupdate" then
            if choke.curr >= config.character.fake_lag_limit then
                choke.curr = 0
                return old_send(net, type, ...)
            else
                choke.curr += 1
                return
            end
        end
    end
    return old_send(net, type, ...)
end