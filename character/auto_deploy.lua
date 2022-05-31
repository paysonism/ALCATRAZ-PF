task.spawn(function()
    while true do
        if config.character.auto_deploy and not menu:isdeployed() then
            menu:deploy()
        end
        task.wait()
    end
end)