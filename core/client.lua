script_name = GetCurrentResourceName()

Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent(Config['Event_base']['getShared_obj'], function(obj) ESX = obj end) 
		Citizen.Wait(0) 
	end 
end)

SM = {}
SM.job = {}
SM.PlayersONline = 0

RegisterNetEvent(script_name..':cl:SendUpdateData', function(objData, allplayers)
	if objData ~= nil then
		SM.job = objData
	end
	if allplayers ~= nil then
		SM.PlayersONline = allplayers
	end
end)

SM_GET_DATA = function(name)
	if name == "allplayer" then
		return SM.PlayersONline
	end
	for k,v in pairs(Config['JobToUse']) do
		if name == v then
			return SM.job[k]
		end
	end
end

RegisterNetEvent(script_name..':getData', function(name, cb)
	if name == "allplayer" then
		cb(SM.PlayersONline)
		return
	end
	for k,v in pairs(Config['JobToUse']) do
		if name == v then
			cb(SM.job[k])
			return
		end
	end
end)