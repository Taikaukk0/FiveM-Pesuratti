ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('pesuratti', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('taikkis_itemit:pesuratti', source)
	xPlayer.removeInventoryItem('pesuratti', 1)
	xPlayer.showNotification(_U('kaytit_pesuratti'))
end)