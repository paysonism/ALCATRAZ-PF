local players = game:GetService("Players")
local player = players.LocalPlayer
local mouse = player:GetMouse()

getgenv().players = players
getgenv().player = player

getgenv().mouse = mouse
getgenv().get_mouse_pos = function()
    return Vector2.new(mouse.X, mouse.Y)
end