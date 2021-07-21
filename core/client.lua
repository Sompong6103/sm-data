script_name = GetCurrentResourceName()

Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent(Config['Event_base']['getShared_obj'], function(obj) ESX = obj end) 
		Citizen.Wait(0) 
	end 
end)

SM = {}
SM.GetAllPlayer = {}
SM.ALLJob = {}
SM.PlayerOnline = 0
SM.JobAllCity = {}

UpdatePlayerClient = function(data_playerjob, ALLNAME)
	for k,v in pairs(ALLNAME) do
		SM.JobAllCity[k] = 0
	end
	
	for key,value in pairs(data_playerjob) do
		for k,v in pairs(SM.JobAllCity) do
			if value.name_job == k then
				SM.JobAllCity[k] = SM.JobAllCity[k] + 1
			end
		end
		
	end
	UpdateClient(SM.JobAllCity)
end

UpdateClient = function(data_arry)
	for kuy, mail3ee in pairs(data_arry) do
		SM.ALLJob[kuy] = mail3ee
	end
end

RegisterNetEvent(script_name..'SendNewJob')
AddEventHandler(script_name..'SendNewJob', function(data_fromServer, player_online, JobAll)
	SM.PlayerOnline = player_online
	UpdatePlayerClient(data_fromServer, JobAll)
end)

RegisterNetEvent(script_name..':getData')
AddEventHandler(script_name..':getData', function(name, cb)
	if name == "allplayer" then
		cb(SM.PlayerOnline)
		return
	end
	for k, v in pairs(SM.ALLJob) do
		if k == name then
			cb(v)
			return
		end
	end
end)

SM_GET_DATA = function(name)
	if name == "allplayer" then
		return SM.PlayerOnline
	end
	for k, v in pairs(SM.ALLJob) do
		if k == name then
			return v
		end
	end
end