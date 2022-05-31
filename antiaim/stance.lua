task.spawn(function()
    while true do
        if config.character.antiaim then
            network:send("stance", config.character.antiaim_stance)
        end
        task.wait()
    end
end)