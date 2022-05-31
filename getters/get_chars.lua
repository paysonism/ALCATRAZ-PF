local characters

for _, v in next, getgc(true) do
    if type(v) == "table" then
        if rawget(v, "getbodyparts") then
            characters = debug.getupvalue(v.getbodyparts, 1)
        end
    end
end

if not characters then
    return error("failed to find characters")
end

getgenv().characters = characters