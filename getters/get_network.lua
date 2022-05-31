local network

for _, v in next, getgc(true) do
    if type(v) == "table" then
        if rawget(v, "send") and rawget(v, "add") then
            network = v
        end
    end
end

if not network then
    return error("failed to find localplayer")
end

getgenv().network = network