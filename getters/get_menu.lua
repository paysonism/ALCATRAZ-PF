local menu

for _, v in next, getgc(true) do
    if type(v) == "table" then
        if rawget(v, "loadmenu") then
            menu = v
        end
    end
end

if not menu then
    return error("failed to find menu")
end

getgenv().menu = menu