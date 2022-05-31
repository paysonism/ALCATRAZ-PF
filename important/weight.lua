--[[
    CREDITS:
    https://stackoverflow.com/a/67877527
]]

getgenv().weighted_random = function(weights)
    local summ = 0
    for i, weight in pairs (weights) do
        summ = summ + weight
    end
    if summ == 0 then return end
    local value = summ*math.random ()
    summ = 0
    for i, weight in pairs (weights) do
        summ = summ + weight
        if value <= summ then
            return i, weight
        end
    end
end