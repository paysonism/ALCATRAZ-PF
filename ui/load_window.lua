local window = library:CreateWindow(
    {
        WindowName = "ALCATRAZ UI - v1.0.1",
        Color = Color3.fromRGB(0, 229, 255),
    },
 
    game.CoreGui
)

local aimbot_tab = window:CreateTab("MAIN")
local character_tab = window:CreateTab("PLAYER MODS")
do
    local fov_circle = Drawing.new("Circle")
    fov_circle.Thickness = 1
    fov_circle.NumSides = 100
    fov_circle.Radius = 180
    fov_circle.Filled = false
    fov_circle.Visible = false
    fov_circle.ZIndex = 999
    fov_circle.Transparency = 1
    fov_circle.Color = Color3.fromRGB(0, 229, 255)
    
    task.spawn(function()
        while true do
            fov_circle.Position = get_mouse_pos() + Vector2.new(0, 36)
            task.wait()
        end
    end)
    
    local silentaim_sector = aimbot_tab:CreateSection("SILENT AIM")
    silentaim_sector:CreateToggle("TRUE", false, function(state)
        config.aimbot.silent_aim = state
    end)
    silentaim_sector:CreateDropdown("HIT PART", {
        "HEAD",
        "TORSO"
    }, function(state)
        config.aimbot.target_part = state
    end)
    silentaim_sector:CreateSlider("HIT CHANCE", 0, 100, 100, true, function(state)
        config.aimbot.hit_chance = state
    end)
    local fieldofview_sector = aimbot_tab:CreateSection("FOV")
    fieldofview_sector:CreateToggle("TRUE", false, function(state)
        config.aimbot.field_of_view = state
    end)
    fieldofview_sector:CreateSlider("RANGE", 0, 360, 180, true, function(state)
        config.aimbot.field_of_view_range = state
        fov_circle.Radius = state
    end)
    fieldofview_sector:CreateColorpicker("COLOR", function(state)
        fov_circle.Color = state
    end)
    fieldofview_sector:CreateToggle("VISIBLE", false, function(state)
        fov_circle.Visible = state
    end)
    fieldofview_sector:CreateToggle("SOLID", false, function(state)
        fov_circle.Filled = state
    end)
    fieldofview_sector:CreateSlider("TRANSPARENCY", 0, 1, 1, false, function(state)
        fov_circle.Transparency = state
    end)
    local gunmod_sector = aimbot_tab:CreateSection("GUN MODS")
    gunmod_sector:CreateToggle("INSTANT RELOAD", false, function(state)
        config.gunmod.fast_reload = state
    end)
    gunmod_sector:CreateToggle("INSTANT EQUIP", false, function(state)
        config.gunmod.fast_equip = state
    end)
end
do
    local movement_sector = character_tab:CreateSection("MOVEMENT")
    movement_sector:CreateToggle("WALKSPEED", false, function(state)
        config.character.walkspeed = state
    end)
    movement_sector:CreateToggle("JUMPOWER", false, function(state)
        config.character.jumppower = state
    end)
    movement_sector:CreateToggle("AUTO DEPLOY", false, function(state)
        config.character.auto_deploy = state
    end)
    movement_sector:CreateToggle("LAG SERVER", false, function(state)
        config.character.fake_lag = state
    end)
    local settings_sector = character_tab:CreateSection("settings")
    settings_sector:CreateSlider("WALKSPEED", 0, 100, 35, true, function(state)
        set_speed(state)
    end)
    settings_sector:CreateSlider("JUMPOWER", 0, 100, 35, true, function(state)
        set_jump_power(state)
    end)
    settings_sector:CreateSlider("LAG", 0, 20, 15, true, function(state)
        config.character.fake_lag_limit = state
    end)
    
    local antiaim_sector = character_tab:CreateSection("ANTI AIM")
    antiaim_sector:CreateToggle("TRUE", false, function(state)
        config.character.antiaim = state
    end)
    antiaim_sector:CreateDropdown("ANTI AIM METHOD", {
        "PRONE",
        "CROUCH",
        "STAND"
    }, function(state)
        config.character.antiaim_stance = state
    end)
end

