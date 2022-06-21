local window = library:CreateWindow(
    {
        WindowName = "ALCATRAZ UI - v1.0.1",
        Color = Color3.fromRGB(179, 51, 196),
    },
    game.CoreGui
)

local aimbot_tab = window:CreateTab("MAIN")
local character_tab = window:CreateTab("CHARACTER")
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
    
    local silentaim_sector = aimbot_tab:CreateSection("Silent Aim")
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
    local fieldofview_sector = aimbot_tab:CreateSection("FOV")
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
    local gunmod_sector = aimbot_tab:CreateSection("Gun Mods")
    gunmod_sector:CreateToggle("fast reload", false, function(state)
        config.gunmod.fast_reload = state
    end)
    gunmod_sector:CreateToggle("fast equip", false, function(state)
        config.gunmod.fast_equip = state
    end)
end
do
    local movement_sector = character_tab:CreateSection("Character Mods")
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
    local settings_sector = character_tab:CreateSection("Settings")
    settings_sector:CreateSlider("walkspeed amount", 0, 100, 35, true, function(state)
        set_speed(state)
    end)
    settings_sector:CreateSlider("jumppower amount", 0, 100, 35, true, function(state)
        set_jump_power(state)
    end)
    settings_sector:CreateSlider("fakelag amount", 0, 20, 15, true, function(state)
        config.character.fake_lag_limit = state
    end)
    
    local antiaim_sector = character_tab:CreateSection("Anti-Aim")
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

local gun_sector = aimbot_tab:CreateSection("All Guns")
    gun_sector:CreateToggle("enabled", false, function(state)
        -- Made By Payson Holmes

-- modules
local network, char, loadgun, loadknife; do
    for _, object in next, getgc(true) do
        if (typeof(object) == "table") then
            if (rawget(object, "send")) then
                network = object;
            elseif (rawget(object, "setbasewalkspeed")) then
                char = object;
            end
        elseif (typeof(object) == "function") then
            local name = debug.getinfo(object).name;

            if (name == "loadgun") then
                loadgun = object;
            elseif (name == "loadknife") then
                loadknife = object;
            end
        end
    end
end

-- services
local replicatedStorage = game:GetService("ReplicatedStorage");

-- cache
local content = replicatedStorage:WaitForChild("Content");
local productionContent = content:WaitForChild("ProductionContent");
local attachmentModules = productionContent:WaitForChild("AttachmentModules");
local gunModules = productionContent:WaitForChild("GunModules");

-- stored data
local gunIgnore = {"JUGGUN", "HK417Old", "PAINTBALL GUN", "RAILGUN OLD", "PPK12", "SVK12E", "MG42"};
local weaponData = {};
local attachmentData = {};
local primaryClasses = { "ASSAULT", "BATTLE", "CARBINE", "SHOTGUN", "PDW", "DMR", "LMG", "SNIPER" };
local generalClassData = {
    ["ASSAULT"] = "AK12",
    ["BATTLE"] = "AK12",
    ["CARBINE"] = "M4A1",
    ["SHOTGUN"] = "KSG 12",
    ["PDW"] = "MP5K",
    ["DMR"] = "INTERVENTION",
    ["LMG"] = "COLT LMG",
    ["SNIPER"] = "INTERVENTION",
    ["PISTOL"] = "M9",
    ["MACHINE PISTOL"] = "M9",
    ["REVOLVER"] = "M9",
    ["OTHER"] = "M9",
    ["FRAGMENTATION"] = "M67 FRAG",
    ["HIGH EXPLOSIVE"] = "M67 FRAG",
    ["IMPACT"] = "M67 FRAG",
    ["ONE HAND BLADE"] = "KNIFE",
    ["TWO HAND BLADE"] = "KNIFE",
    ["ONE HAND BLUNT"] = "MAGLITE CLUB",
    ["TWO HAND BLUNT"] = "HOCKEY STICK",
};
local weapons = {};

-- hooks
do
    local oldNetworkSend = network.send; network.send = function(self, name, ...)
        local args = {...};

        if (name == "changewep") then
            weaponData[args[1]] = args[2];
            args[2] = generalClassData[weapons[args[2]].type];
        end
print("Made By Payson Holmes")
print("ALL GUNS UNLOCKED")
        if (name == "changeatt") then
            attachmentData[args[2]] = args[3];
            return
        end

        return oldNetworkSend(self, name, unpack(args));
    end

    local oldLoadgrenade = char.loadgrenade; char.loadgrenade = function(self, name, ...)
        name = weaponData["Grenade"] or name;
        return oldLoadgrenade(self, name, ...);
    end;
    game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "ALCATRAZ UI",
    Text = "ALL GUNS ACTIVE", 
    Duration = 8
    })
    local oldLoadknife; oldLoadknife = hookfunction(loadknife, function(name, ...)
        name = weaponData["Knife"] or name;
        return oldLoadknife(name, ...);
    end);

    local oldLoadgun; oldLoadgun = hookfunction(loadgun, function(name, magsize, sparerounds, attachments, ...)
        local gunData = weapons[name];
        local newName = table.find(primaryClasses, gunData.type) and weaponData["Primary"] or weaponData["Secondary"];

        name = (newName and newName or name);

        local attachs = attachmentData[name];

        if (attachs) then
            attachments = attachs;
        end

        return oldLoadgun(name, magsize, sparerounds, attachments, ...);
    end);
end

-- init
do
    for _, module in next, gunModules:GetChildren() do
        if (not table.find(gunIgnore, module.Name)) then
            local data = require(module);
            weapons[module.Name] = data;
        end
    end

    for _, module in next, attachmentModules:GetChildren() do
        local data = require(module);
        data.unlockkills = 0;
    end

    for _, module in next, gunModules:GetChildren() do
        if (not table.find(gunIgnore, module.Name)) then
            local data = require(module);
            data.unlockrank = 0;
            data.adminonly = false;
            data.supertest = false;
            data.exclusiveunlock = false;
            data.hideunlessowned = false;
        end
    end
end
    end)
