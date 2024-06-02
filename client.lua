RegisterNetEvent('god_announcements:showAnnouncement')
AddEventHandler('god_announcements:showAnnouncement', function(msg, playerName, playerId)
    SendNUIMessage({
        type = "ui",
        display = true,
        message = msg,
        playerName = playerName,
        playerId = playerId
    })
    
    -- Hide the announcement after 10 seconds
    Citizen.SetTimeout(10000, function()
        SendNUIMessage({
            type = "ui",
            display = false
        })
    end)
end)






















































