ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local isBusy = false

RegisterNetEvent('taikkis_itemit:pesuratti')
AddEventHandler('taikkis_itemit:pesuratti', function(source)

	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
		Citizen.CreateThread(function()
			Citizen.Wait(10000)

			SetVehicleDirtLevel(vehicle, 0)
			ClearPedTasksImmediately(playerPed)

			ESX.ShowNotification(_U('vehicle_cleaned'))
			isBusy = false
		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end

	TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Pestään ajoneuvoa...",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
		if not status then
			-- HOMOILEE
        end
	end)
	
end)