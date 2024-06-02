local QBCore = exports['qb-core']:GetCoreObject()

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
    -- Wait for Config to be loaded
    while not Config.AnnounceStaffCommand do
        Wait(100)
    end

    RegisterCommand(Config.AnnounceStaffCommand, function(source, args, rawCommand)
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
            TriggerClientEvent('QBCore:Notify', source, 'You do not have permission to use this command', 'error')
        end
    end, false)
end)
































