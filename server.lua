-- Load the configuration
Config = {}
CreateThread(function()
    local configFile = LoadResourceFile(GetCurrentResourceName(), 'config.lua')
    if configFile then
        local configFunction = load(configFile)
        if configFunction then
            Config = configFunction() or Config
            print("Config loaded successfully")
        else
            print("Error: Could not load config.lua")
        end
    else
        print("Error: config.lua not found")
    end
end)

CreateThread(function()
    while not QBCore do -- Wait until QBCore is properly initialized
        Wait(100)
        QBCore = exports['qb-core']:GetCoreObject()
    end

    -- Wait for Config to be loaded
    while not Config.AnnounceStaffCommand do
        Wait(100)
    end

    -- Register the command with a description
    local description = "Announce a message to all members [Messge]"
    QBCore.Commands.Add(Config.AnnounceStaffCommand, description, {}, false, function(source, args)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        
        local hasPermission = false

        -- Check if the player has any of the allowed roles
        for _, role in ipairs(Config.AllowedRoles) do
            if QBCore.Functions.HasPermission(source, role) then
                hasPermission = true
                break
            end
        end

        if hasPermission then
            local msg = table.concat(args, " ")
            local playerName = GetPlayerName(source)
            local playerId = source
            TriggerClientEvent('god_announcements:showAnnouncement', -1, msg, playerName, playerId)
        else
            -- Print to console as Notify function not available
            print("You do not have permission to use this command.")
        end
    end)
end)
































