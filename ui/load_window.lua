if game.PlaceId == 292439477 then

    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "ALCATRAZ-PF",
        Text = "v1.0.7 STABLE", 
        Duration = 8
        })

        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Discord Server",
            Text = "https://dsc.gg/PDennSploit", 
            Duration = 8
            })

            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Credits",
                Text = "Made By Payson Holmes", 
                Duration = 8
                })

    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("ALCATRAZ - v1.0.7 STABLE", "Ocean")
    local Main = Window:NewTab("Main")
    local Mods = Window:NewTab("Mods")
    local Extra = Window:NewTab("Extra")
    local Creds = Window:NewTab("Credits")
    local sa = Main:NewSection("Silent Aim")
    local esp = Main:NewSection("ESP")
    local fov = Main:NewSection("FOV")
    local gm = Mods:NewSection("Gun Mods")
    local pm = Mods:NewSection("Player Mods")
    local settings = Mods:NewSection("Settings")
    local tgl = Extra:NewSection("Toggles")
    local configs = Extra:NewSection("Configs")
    local credit = Creds:NewSection("Credits")

    -- Main Tab

    sa:NewToggle("Silent Aim", "Toggles Silent Aim on or Off", function(state)
        config.aimbot.silent_aim = state
    end)

    sa:NewDropdown("Hit Part", "Switches where the bullets will hit the enemy player.", {"Head", "Torso"}, function(state)
        config.aimbot.target_part = state
    end)

    sa:NewSlider("Hit Chance", "The percentage of bullets that will strike the enemy. Out of 100.", 100, 0, function(state)
        config.aimbot.hit_chance = state
    end)

    esp:NewButton("ESP", "Opens the ESP UI.", function(state)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/P-DennyGamingYT/ALCATRAZ-PF/main/aiming/ESP.lua"))()
    end)

    fov:NewToggle("FOV", "Toggles FOV on or off.", function(state)
        config.aimbot.field_of_view = state
    end)

    fov:NewSlider("Range", "The range of the FOV.", 360, 0, function(state)
        config.aimbot.field_of_view_range = state
        fov_circle.Radius = state
    end)

    fov:NewColorPicker("Color", "Color of the FOV circle.", Color3.fromRGB(255,255,255), function(state)
        fov_circle.Color = state
    end)

    fov:NewToggle("Visible", "Toggles FOV Visibility", function(state)
        fov_circle.Visible = state
    end)
    
    fov:NewToggle("Filled", "Toggles FOV fill on or off.", function(state)
        fov_circle.Filled = state
    end)

    fov:NewSlider("Transparency", "The transparency of the FOV.", 100, 100, function(state)
        fov_circle.Transparency = state
    end)

    gm:NewToggle("Instant Reload", "Toggles whether instant reload is on or not.", function(state)
        config.gunmod.fast_reload = state
    end)

    gm:NewToggle("Instant Equip", "Toggles whether you instantly equip a weapon.", function(state)
        config.gunmod.fast_equip = state
    end)

    gm:NewButton("All Guns", "Grants you access to all guns. (Includes Admin Guns).", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/P-DennyGamingYT/ALCATRAZ-PF/main/gunmod/allgun.lua"))()
    end)

    gm:NewButton("Skin Editor", "Opens the Skin Editor UI.", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/P-DennyGamingYT/ALCATRAZ-PF/main/gunmod/skin_edit.lua"))()
    end)

    pm:NewToggle("Walkspeed", "Walkspeed Mods", function(state)
        config.character.walkspeed = state
    end)

    pm:NewToggle("Jumppower", "Jumppower Mods", function(state)
        config.character.jumppower = state
    end)

    pm:NewToggle("Fake Lag", "Fake character lag.", function(state)
        config.character.fake_lag = state
    end)

    pm:NewToggle("Auto Deploy", "Automatically deploy's your character.", function(state)
        config.character.auto_deploy = state
    end)

    pm:NewToggle("Anti-Aim", "Toggles Anti Aim on or off.", function(state)
        config.character.antiaim = state
    end)

    pm:NewDropdown("Stance", "The stance Anti-Aim will use", {"Prone", "Crouch", "Stand"}, function(state)
        config.character.antiaim_stance = state
    end)
    

    settings:NewSlider("Walkspeed", "Changes your walkspeed", 150, 16, function(state) -- 500 (MaxValue) | 0 (MinValue)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = state
    end)

    settings:NewSlider("Jumppower", "Changes your jumppower.", 150, 55, function(state) -- 500 (MaxValue) | 0 (MinValue)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = state
    end)

    settings:NewSlider("Fake Lag", "Creates fake lag on your character.", 20, 15, function(state) -- 500 (MaxValue) | 0 (MinValue)
        config.character.fake_lag_limit = state
    end)

    tgl:NewKeybind("UI Toggle", "Toggle's the visibility of the UI.", Enum.KeyCode.LeftAlt, function()
        Library:ToggleUI()
    end)

    configs:NewLabel("IN DEVELOPMENT")
    configs:NewLabel("COMING SOON!")

    credit:NewLabel("Payson Holmes - GUI & Scripting")
    credit:NewLabel("xHeptc - UI Lib")




    
    local fov_circle = Drawing.new("Circle")
    fov_circle.Thickness = 1
    fov_circle.NumSides = 100
    fov_circle.Radius = 180
    fov_circle.Filled = false
    fov_circle.Visible = false
    fov_circle.ZIndex = 999
    fov_circle.Transparency = 100
    fov_circle.Color = Color3.fromRGB(255, 255, 255)
    
    task.spawn(function()
        while true do
            fov_circle.Position = get_mouse_pos() + Vector2.new(0, 36)
            task.wait()
        end
    end)
else 
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "UNSUPPORTED GAME",
        Text = "ALCATRAZ CURRENTLY ONLY SUPPORTS PHANTOM FORCES.", 
        Duration = 8
        })
end 