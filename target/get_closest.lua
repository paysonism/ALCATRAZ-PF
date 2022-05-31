getgenv().get_closest = function()
    local c_player, c_bodyparts, c_distance

    for _, _player in next, players:GetChildren() do
        if _player == player then continue end
        local character = characters[_player]
        if character then
            local torso = character.torso
            if not torso then continue end
            local v2, onscreen = get_v2(torso.Position)
            if onscreen then
                local distance = (get_mouse_pos() - v2).Magnitude
                if distance <= (c_distance or config.aimbot.field_of_view and config.aimbot.field_of_view_range or 2000) then
                    c_player = _player
                    c_bodyparts = character
                    c_distance = distance
                end
            end
        end
    end

    return c_player, c_bodyparts
end