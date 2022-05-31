local window = library:CreateWindow(
    {
        WindowName = "purple haze - phantom forces",
        Color = Color3.fromRGB(179, 51, 196),
    },
    game.CoreGui
)

local aimbot_tab = window:CreateTab("aimbot")
local character_tab = window:CreateTab("character")
do
    local fov_circle = Drawing.new("Circle")
    fov_circle.Thickness = 1
    fov_circle.NumSides = 100
    fov_circle.Radius = 180
    fov_circle.Filled = false
    fov_circle.Visible = false
    fov_circle.ZIndex = 999
    fov_circle.Transparency = 1
    fov_circle.Color = Color3.fromRGB(255, 255, 255)
    
    task.spawn(function()
        while true do
            fov_circle.Position = get_mouse_pos() + Vector2.new(0, 36)
            task.wait()
        end
    end)
    
    local silentaim_sector = aimbot_tab:CreateSection("silent aim")
    silentaim_sector:CreateToggle("enabled", false, function(state)
        config.aimbot.silent_aim = state
    end)
    silentaim_sector:CreateDropdown("hit part", {
        "head",
        "torso"
    }, function(state)
        config.aimbot.target_part = state
    end)
    silentaim_sector:CreateSlider("hit chance %", 0, 100, 100, true, function(state)
        config.aimbot.hit_chance = state
    end)
    local fieldofview_sector = aimbot_tab:CreateSection("field of view")
    fieldofview_sector:CreateToggle("enabled", false, function(state)
        config.aimbot.field_of_view = state
    end)
    fieldofview_sector:CreateSlider("range", 0, 360, 180, true, function(state)
        config.aimbot.field_of_view_range = state
        fov_circle.Radius = state
    end)
    fieldofview_sector:CreateColorpicker("color", function(state)
        fov_circle.Color = state
    end)
    fieldofview_sector:CreateToggle("visible", false, function(state)
        fov_circle.Visible = state
    end)
    fieldofview_sector:CreateToggle("filled", false, function(state)
        fov_circle.Filled = state
    end)
    fieldofview_sector:CreateSlider("transparency", 0, 1, 1, false, function(state)
        fov_circle.Transparency = state
    end)
    local gunmod_sector = aimbot_tab:CreateSection("gun mod")
    gunmod_sector:CreateToggle("fast reload", false, function(state)
        config.gunmod.fast_reload = state
    end)
    gunmod_sector:CreateToggle("fast equip", false, function(state)
        config.gunmod.fast_equip = state
    end)
end
do
    local movement_sector = character_tab:CreateSection("movement")
    movement_sector:CreateToggle("walkspeed", false, function(state)
        config.character.walkspeed = state
    end)
    movement_sector:CreateToggle("jumppower", false, function(state)
        config.character.jumppower = state
    end)
    movement_sector:CreateToggle("auto deploy", false, function(state)
        config.character.auto_deploy = state
    end)
    movement_sector:CreateToggle("fake lag ( might be buggy )", false, function(state)
        config.character.fake_lag = state
    end)
    local settings_sector = character_tab:CreateSection("settings")
    settings_sector:CreateSlider("walkspeed amount", 0, 100, 35, true, function(state)
        set_speed(state)
    end)
    settings_sector:CreateSlider("jumppower amount", 0, 100, 35, true, function(state)
        set_jump_power(state)
    end)
    settings_sector:CreateSlider("fakelag amount", 0, 20, 15, true, function(state)
        config.character.fake_lag_limit = state
    end)
    
    local antiaim_sector = character_tab:CreateSection("anti aim")
    antiaim_sector:CreateToggle("enabled", false, function(state)
        config.character.antiaim = state
    end)
    antiaim_sector:CreateDropdown("stance type", {
        "prone",
        "crouch",
        "stand"
    }, function(state)
        config.character.antiaim_stance = state
    end)
end