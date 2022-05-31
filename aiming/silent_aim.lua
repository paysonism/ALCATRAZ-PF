-- local l__CFrame__1003 = (u215 and u211.sightpart or v909).CFrame;
-- (is_aiming and SIGHT or Barrel).cframe

local function is_gunsight(t)
    local sightparts = gun_system.currentgun and gun_system.currentgun.aimsightdata
    for _, sightdata in next, sightparts do
        if sightdata.sightpart == t then
            return true
        end
    end
    return false
end

local old_index old_index = hookmetamethod(game, "__index", function(t, k)
    if k == "CFrame" and config.aimbot.silent_aim and gun_system.currentgun and (is_gunsight(t) or t == gun_system.currentgun.barrel) then
        local r = weighted_random({hit = config.aimbot.hit_chance,miss = 100 - config.aimbot.hit_chance})

        local cf = old_index(t, k)
        local c_player, c_bodyparts = get_closest()
        if c_player and c_bodyparts and c_player.Team ~= player.Team and r == "hit" then
            return CFrame.new(
                cf.Position,
                c_bodyparts[config.aimbot.target_part].Position
            )
        end
    end
    return old_index(t, k)
end)