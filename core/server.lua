ESX = nil 
script_name = GetCurrentResourceName()

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    TriggerEvent(Config['Event_base']['getShared_obj'], function(obj) ESX = obj end)
    while ESX == nil do
        Citizen.Wait(5)
    end
    print("^2["..script_name.."] ^5Can use")
end)

SM = {}
SM.All_Player = {}
SM.PLAYER_Online = 0

AddEventHandler(Config["Event_base"]["playerLoaded"], function(source, job, lastJob)
    SM.All_Player[source] = {}
    SM.All_Player[source].name_job = job.name
    TriggerClientEvent(script_name..'SendNewJob', -1, SM.All_Player, SM.PLAYER_Online, ESX.Jobs)
end)

AddEventHandler(Config["Event_base"]["playerLoaded"], function(playerId, reason)
    SM.PLAYER_Online = SM.PLAYER_Online + 1
    PLAYER_LOAD(playerId)
end)

AddEventHandler(Config["Event_base"]["playerDropped"], function(playerId, reason)
    print("ok Disconnect")
    SM.All_Player[playerId] = nil
    SM.PLAYER_Online = SM.PLAYER_Online - 1
    TriggerClientEvent(script_name..'SendNewJob', -1, SM.All_Player, SM.PLAYER_Online, ESX.Jobs)
end)


AddEventHandler('onResourceStart', function(resourceName)
    if (script_name == resourceName) then
        while ESX == nil do
            Citizen.Wait(5)
        end
        local xPlayers = ESX.GetPlayers()
        SM.PLAYER_Online = #xPlayers
        for i=1, #xPlayers do
            Citizen.Wait(100)
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            SM.All_Player[xPlayer.source] = {}
            SM.All_Player[xPlayer.source].name_job = xPlayer.getJob().name
        end
        TriggerClientEvent(script_name..'SendNewJob', -1, SM.All_Player, SM.PLAYER_Online, ESX.Jobs)
    end
end)

PLAYER_LOAD = function(id_player)
    local xPlayer = ESX.GetPlayerFromId(id_player)
    SM.All_Player[id_player] = {}
    SM.All_Player[id_player].name_job = xPlayer.getJob().name
    TriggerClientEvent(script_name..'SendNewJob', -1, SM.All_Player, SM.PLAYER_Online, ESX.Jobs)
end