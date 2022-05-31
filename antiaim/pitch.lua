local old_send = network.send

function network.send(net, type, ...)
    return old_send(net, type, ...)
end