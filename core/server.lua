ESX = nil 
script_name = GetCurrentResourceName()

SMdata = {}

Citizen.CreateThread(function()
    SMdata.job = {}
    for k,v in pairs(Config['JobToUse']) do
        SMdata.job[k] = 0
    end
    TriggerEvent(Config['Event_base']['getShared_obj'], function(obj) ESX = obj end)
    while ESX == nil do
        Citizen.Wait(5)
    end
    print("^2["..script_name.."] ^5Can Use Script")
end)

function checkJobNameCanSend(playerJobName, status)
    for k,v in pairs(Config['JobToUse']) do
        if playerJobName == v then
            if status then
                SMdata.job[k] = SMdata.job[k] + 1
            else
                SMdata.job[k] = SMdata.job[k] - 1
            end
            return true
        end
    end
    return false
end

AddEventHandler(Config["Event_base"]["setJob"], function(source, job, lastJob)
    checkJobNameCanSend(job.name, true)
    checkJobNameCanSend(lastJob.name, false)
    TriggerClientEvent(script_name..':cl:SendUpdateData', -1, SMdata.job, GetNumPlayerIndices())
end)

AddEventHandler(Config["Event_base"]["playerLoaded"], function(playerId, xPlayer)
    local result = checkJobNameCanSend(xPlayer.job.name, true)
    if result then
        TriggerClientEvent(script_name..':cl:SendUpdateData', -1, SMdata.job, GetNumPlayerIndices())
    else
        TriggerClientEvent(script_name..':cl:SendUpdateData', -1, nil, GetNumPlayerIndices())
    end
end)

AddEventHandler(Config["Event_base"]["playerDropped"], function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local result = checkJobNameCanSend(xPlayer.job.name, false)
    if result then
        TriggerClientEvent(script_name..':cl:SendUpdateData', -1, SMdata.job, GetNumPlayerIndices())
    else
        TriggerClientEvent(script_name..':cl:SendUpdateData', -1, nil, GetNumPlayerIndices())
    end
end)


AddEventHandler('onResourceStart', function(resourceName)
    if (script_name == resourceName) then
        while ESX == nil do
            Citizen.Wait(5)
        end
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers do
            Citizen.Wait(100)
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            local result = checkJobNameCanSend(xPlayer.job.name, true)
        end
        TriggerClientEvent(script_name..':cl:SendUpdateData', -1, SMdata.job, GetNumPlayerIndices())
    end
end)
