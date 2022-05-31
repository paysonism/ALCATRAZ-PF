local localplayer

for _, v in next, getgc(true) do
    if type(v) == "table" then
        if rawget(v, "setbasewalkspeed") then
            localplayer = v
        end
    end
end

if not localplayer then
    return error("failed to find localplayer")
end

getgenv().localplayer = localplayer