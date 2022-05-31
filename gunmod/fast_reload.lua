task.spawn(function()
    while true do
        if config.gunmod.fast_reload and gun_system and gun_system.currentgun and gun_system.currentgun.data then
            for i,v in next, gun_system.currentgun.data.animations do
                if type(i) == "string" and i:lower():gmatch("reload") then
                    for d,k in next, v do
                        if type(k) == "table" then
                            k.delay = 0.01
                        end
                    end
                end
            end
        end
        task.wait()
    end
end)