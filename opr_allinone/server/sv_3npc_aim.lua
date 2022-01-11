ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("keys:checkMoneyDrop")
AddEventHandler("keys:checkMoneyDrop", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if config.give_cash then
        if math.random()<=config.give_cash_chance/100 then
            local cash = math.random(config.give_cash_min,config.give_cash_max)
            TriggerClientEvent('esx:showNotification', _source, config.give_cash_msg:format(tostring(cash)))
            xPlayer.addMoney(tonumber(cash))
        end
    end
end)