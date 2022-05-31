local gun_system

for _, v in next, getgc(true) do
    if type(v) == "table" then
        if rawget(v, "setsprintdisable") then
            gun_system = v
        end
    end
end

if not gun_system then
    return error("failed to find gun_system")
end

getgenv().gun_system = gun_system