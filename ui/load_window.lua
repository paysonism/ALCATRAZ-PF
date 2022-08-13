local window = library:CreateWindow(
    {
        WindowName = "ALCATRAZ UI - v1.0.3",
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
        
    game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "ALCATRAZ UI",
    Text = "ALL GUNS ACTIVE", 
    Duration = 8
    })
        -- ALL GUNS START
        
        -- Made By Payson Holmes

local upvalueFix = function(func) return function(...) return func(...); end end

local network, char, gamelogic, particle, dataStoreClient, playerDataUtils, contentDatabase, call, networkCalls; do
    for _, object in next, getgc(true) do
        if (typeof(object) == "table") then
            if (rawget(object, "send")) then
                network = object;
            elseif (rawget(object, "loadgrenade")) then
                char = object;
            elseif (rawget(object, "gammo")) then
                gamelogic = object;
            elseif (rawget(object, "new") and rawget(object, "reset")) then
                particle = object;
            elseif (rawget(object, "getPlayerData") and rawget(object, "isDataReady")) then
                dataStoreClient = object;
            elseif (rawget(object, "rankCalculator") and rawget(object, "getPlayerRank")) then
                playerDataUtils = object;
            elseif (rawget(object, "getAllWeaponsList")) then
                contentDatabase = object;
            end
        elseif (typeof(object) == "function") then
            local info = debug.getinfo(object);

            if (info.name == "call" and string.find(info.short_src, "network")) then
                call = object;
                networkCalls = debug.getupvalue(object, 1);
            end
        end
    end
end

-- services
local players = game:GetService("Players");
local runService = game:GetService("RunService");
local replicatedSotrage = game:GetService("ReplicatedStorage");

-- cache
local localPlayer = players.LocalPlayer;
local content = replicatedSotrage:WaitForChild("Content");
local productionContent = content:WaitForChild("ProductionContent");
local attachmentDatabase = productionContent:WaitForChild("AttachmentDatabase");
local categories = attachmentDatabase:WaitForChild("Categories");

-- data
local defaultWeaponCache = {
    ["ASSAULT RIFLE"] = "AK12",
    ["BATTLE RIFLE"] = "AK12",
    ["CARBINE"] = "M4A1",
    ["PDW"] = "MP5K",
    ["DMR"] = "M9",
    ["SHOTGUN"] = "KSG 12",
    ["LMG"] = "COLT LMG",
    ["SNIPER RIFLE"] = "INTERVENTION",
    ["PISTOLS"] = "M9",
    ["MACHINE PISTOLS"] = "G17",
    ["REVOLVERS"] = "M9",
    ["OTHER"] = {
        ["SUPER SHORTY"] = "KSG 12",
        ["SFG 50"] = "INTERVENTION",
        ["M79 THUMPER"] = "M4A1",
        ["COILGUN"] = "M9",
        ["SAWED OFF"] = "KSG 12",
        ["SAIGA-12U"] = "M9",
        ["ORBEZ"] = "INTERVENTION",
        ["SASS 308"] = "INTERVENTION",
    },
    ["FRAGMENTATION"] = "M67 FRAG",
    ["HIGH EXPLOSIVE"] = "DYNAMITE",
    ["IMPACT"] = "M67 FRAG",
    ["ONE HAND BLADE"] = "KNIFE",
    ["TWO HAND BLADE"] = "KNIFE",
    ["ONE HAND BLUNT"] = "MAGLITE CLUB",
    ["TWO HAND BLUNT"] = "HOCKEY STICK"
};
local weaponClassType = {
    ["ASSAULT RIFLE"] = "Primary",
    ["BATTLE RIFLE"] = "Primary",
    ["CARBINE"] = "Primary",
    ["PDW"] = "Primary",
    ["DMR"] = "Primary",
    ["SHOTGUN"] = "Primary",
    ["LMG"] = "Primary",
    ["SNIPER RIFLE"] = "Primary",
    ["PISTOLS"] = "Secondary",
    ["MACHINE PISTOLS"] = "Secondary",
    ["REVOLVERS"] = "Secondary",
    ["OTHER"] = "Secondary",
    ["FRAGMENTATION"] = "Grenade",
    ["HIGH EXPLOSIVE"] = "Grenade",
    ["IMPACT"] = "Grenade",
    ["ONE HAND BLADE"] = "Knife",
    ["TWO HAND BLADE"] = "Knife",
    ["ONE HAND BLUNT"] = "Knife",
    ["TWO HAND BLUNT"] = "Knife"
};
local selecedWeapons = {};
local selectedAttachments = {};

-- loops
do
    runService.Heartbeat:Connect(function()
        if (dataStoreClient.isDataReady()) then
            local playerData = dataStoreClient.getPlayerData(localPlayer);
            local rank = playerDataUtils.getPlayerRank(playerData);

            defaultWeaponCache["DMR"] = (rank >= 2 and "MK11" or "M9");
            defaultWeaponCache["REVOLVERS"] = (rank >= 4 and "MP412 REX" or "M9");
        end
    end);
end

-- hooks
do
    local oldCall; oldCall = hookfunction(call, upvalueFix(function(name, ...)
        local args = {...};

        if (name == "bigaward") then
            local class = contentDatabase.getWeaponClass(args[3]);
            local selectedWeapon = selecedWeapons[weaponClassType[class]];

            if (selectedWeapon) then
                args[3] = selectedWeapon;
            end
        elseif (name == "killfeed" and args[1] == localPlayer) then
            local class = contentDatabase.getWeaponClass(args[4]);
            local selectedWeapon = selecedWeapons[weaponClassType[class]];

            if (selectedWeapon) then
                args[4] = selectedWeapon;
            end
        end

        return oldCall(name, unpack(args));
    end));

    local oldNetworkSend = network.send; network.send = function(self, name, ...)
        local args = {...};

        if (name == "newbullets") then
            local gunName = gamelogic.currentgun.name;
            local class = contentDatabase.getWeaponClass(gunName);
            local weaponData = contentDatabase.getWeaponData((typeof(defaultWeaponCache[class]) == "table" and defaultWeaponCache[class][gunName] or defaultWeaponCache[class]));

            for _, bullet in next, args[1].bullets do
                bullet[1] = bullet[1].Unit * weaponData.bulletspeed;
            end
        end

        if (name == "changeWeapon") then
            local class = contentDatabase.getWeaponClass(args[2]);
            selecedWeapons[args[1]] = args[2];
            args[3] = (typeof(defaultWeaponCache[class]) == "table" and defaultWeaponCache[class][args[2]] or defaultWeaponCache[class]);
        elseif (name == "changeAttachment") then
            local name = selecedWeapons[args[1]] or "NONE";

            if (not selectedAttachments[name]) then
                selectedAttachments[name] = {};
            end

            selectedAttachments[name][args[2]] = args[3] or "";
            return
        end

        return oldNetworkSend(self, name, unpack(args));
    end

    setreadonly(particle, false); local oldParticleNew = particle.new; particle.new = function(data)
        if (data and data.onplayerhit and data.ontouch) then
            local currentGun = gamelogic.currentgun;

            if (currentGun) then
                local gunName = gamelogic.currentgun.name;
                local class = contentDatabase.getWeaponClass(gunName);
                local weaponData = contentDatabase.getWeaponData((typeof(defaultWeaponCache[class]) == "table" and defaultWeaponCache[class][gunName] or defaultWeaponCache[class]));

                if (weaponData) then
                    data.velocity = data.velocity.Unit * weaponData.bulletspeed;
                end
            end
        end

        return oldParticleNew(data);
    end

    local oldLoadGrenade = char.loadgrenade; char.loadgrenade = function(self, name, ...)
        local class = contentDatabase.getWeaponClass(name);
        local selectedWeapon = selecedWeapons[weaponClassType[class]];

        if (selectedWeapon) then
            name = selectedWeapon;
        end

        return oldLoadGrenade(self, name, ...);
    end

    local loadgun, loadknife; do
        for index, object in next, debug.getupvalues(networkCalls.spawn) do
            if (typeof(object) == "function") then
                local info = debug.getinfo(object);

                if (info.name == "loadgun") then
                    loadgun = index;
                elseif (info.name == "loadknife") then
                    loadknife = index;
                end
            end
        end

        local oldLoadgun = debug.getupvalue(networkCalls.spawn, loadgun); debug.setupvalue(networkCalls.spawn, loadgun, function(name, magsize, sparerounds, attachments, ...)
            local class = contentDatabase.getWeaponClass(name);
            local gunType = weaponClassType[class]
            local selectedWeapon = selecedWeapons[gunType];
            local attachmentData = selectedAttachments[selectedWeapon];

            if (selectedWeapon) then
                name = selectedWeapon;
            end

            if (attachmentData) then
                attachments = attachmentData;
            end

            return oldLoadgun(name, magsize, sparerounds, attachments, ...);
        end);

        local oldLoadknife = debug.getupvalue(networkCalls.spawn, loadknife); debug.setupvalue(networkCalls.spawn, loadknife, function(name, ...)
            local class = contentDatabase.getWeaponClass(name);
            local selectedWeapon = selecedWeapons[weaponClassType[class]];

            if (selectedWeapon) then
                name = selectedWeapon;
            end

            return oldLoadknife(name, ...);
        end);
    end
end

-- inits
do
    for _, name in next, contentDatabase.getAllWeaponsList() do
        local weaponData = contentDatabase.getWeaponData(name);
        setreadonly(weaponData, false);

        weaponData.unlockrank = 0;
        weaponData.exclusiveunlock = false;
        weaponData.hideunlessowned = false;
        weaponData.supertest = false;
        weaponData.adminonly = false;
    end

    for _, instance in next, categories:GetDescendants() do
        if (instance:IsA("ModuleScript") and instance.Name == "AttachmentData") then
            local attachmentData = require(instance);
            setreadonly(attachmentData, false);

            attachmentData.unlockkills = 0;
        end
    end
end

-- Made By Payson Holmes
        
        -- ALL GUNS END
        
   
end
    end
    end)
