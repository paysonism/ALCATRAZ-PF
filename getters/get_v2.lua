local camera = workspace.CurrentCamera

getgenv().get_v2 = function(v3)
    local point, onscreen = camera:WorldToViewportPoint(v3)
    return Vector2.new(
        point.X,
        point.Y
    ),
    onscreen
end