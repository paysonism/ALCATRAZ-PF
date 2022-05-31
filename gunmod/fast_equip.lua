task.spawn(function()
    while true do
        if config.gunmod.fast_equip and gun_system and gun_system.currentgun and gun_system.currentgun.data then
            gun_system.currentgun.data.equipspeed = 1000
        end
        task.wait()
    end
end)