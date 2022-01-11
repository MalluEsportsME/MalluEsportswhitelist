ESX	= nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterCommand('fpsmenu', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('fps:openfps', _source)
end)

