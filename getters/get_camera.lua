local camera

for _, v in next, getgc(true) do
    if type(v) == "table" then
        if rawget(v, "setswayspeed") then
            camera = v
        end
    end
end

if not camera then
    return error("failed to find camera")
end

getgenv().camera = camera