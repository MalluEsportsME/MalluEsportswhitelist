ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('loffe_burglary:getDoorFreezeStatus', function(source, cb, house)
    cb(config.Burglary[house].Door.Frozen)
end)

ESX.RegisterServerCallback('loffe_burglary:getDoorHealth', function(source, cb, house)
    cb(config.Burglary[house].Door.Health)
end)

RegisterServerEvent('loffe_burglary:setDoorFreezeStatus')
AddEventHandler('loffe_burglary:setDoorFreezeStatus', function(house, status)
    if status == false then
        local src = source
        local cops = 0
        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                cops = cops + 1
            end
        end
        if cops >= config.Burglary[house].Cops then
            config.Burglary[house].Door.Frozen = status
        else
            TriggerClientEvent('showNotification', src, 'There arent enough cops online!')
        end
    else
        config.Burglary[house].Door.Frozen = status
        config.Burglary[house].Door.Health = 1000
        TriggerClientEvent('loffe_burglary:setHealth', -1, house, config.Burglary[house].Door.Health)
    end
    TriggerClientEvent('loffe_burglary:setFrozen', -1, house, config.Burglary[house].Door.Frozen)
end)

RegisterServerEvent('loffe_burglary:setDoorHealth')
AddEventHandler('loffe_burglary:setDoorHealth', function(house, health)
    local src = source
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end
    if cops >= config.Burglary[house].Cops then
        config.Burglary[house].Door.Health = health
    else
        TriggerClientEvent('showNotification', src, 'There arent enough cops online!')
    end
    TriggerClientEvent('loffe_burglary:setHealth', -1, house, config.Burglary[house].Door.Health)
end)

RegisterServerEvent('loffe_burglary:loot')
AddEventHandler('loffe_burglary:loot', function(house, furniture)
    local src = source
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end
    if cops >= config.Burglary[house].Cops then
        config.Burglary[house].MultipleSearch[furniture].Items = config.Burglary[house].MultipleSearch[furniture].Items - 1
        TriggerClientEvent('loffe_burglary:setItems', -1, house, furniture, config.Burglary[house].MultipleSearch[furniture].Items)
        Wait(6500)
        local xPlayer = ESX.GetPlayerFromId(src)
        local randomItem = math.random(1, #config.Items)
        local randomAmount = math.random(1, 5)
        if config.Items[randomItem].Amount ~= nil then
            xPlayer.addInventoryItem(config.Items[randomItem].Name, config.Items[randomItem].Amount)
            TriggerClientEvent('showNotification', src, 'You found' .. config.Items[randomItem].Amount .. ' ' .. config.Items[randomItem].Label)
        else
            xPlayer.addInventoryItem(config.Items[randomItem].Name, randomAmount)
            TriggerClientEvent('showNotification', src, 'You found' .. randomAmount .. ' ' .. config.Items[randomItem].Label)
        end
    else
        TriggerClientEvent('showNotification', src, 'There arent enough cops online!')
    end
end)
