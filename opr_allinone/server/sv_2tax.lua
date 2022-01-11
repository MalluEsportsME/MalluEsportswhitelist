ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetUsersForTax(d, h, m)
    MySQL.ready(function()        
        MySQL.Async.fetchAll('SELECT * FROM users',{},function(AllUser)
            RunTax(AllUser)
        end)
    end)  
end

-- Car Taxing
function CarsTax(AllUser)     
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles',{},function(AllCars)
        local taxMultiplier = config.CarTax
        for i=1 , #AllUser,1 do 
            local carCount = 0
            for a=1 , #AllCars,1 do 
                if AllUser[i].identifier == AllCars[a].owner and (AllCars[a].job ~= 'police' and AllCars[a].job ~= 'ambulance') then
                    carCount = carCount + 1
                end
            end
            if carCount > 0 then
                local tax = carCount * taxMultiplier
                local xPlayer = ESX.GetPlayerFromIdentifier(AllUser[i].identifier)
                if(xPlayer ~= nil) then                     
                    TriggerClientEvent('tax:sendTax', xPlayer.source, xPlayer.source, 'Car Tax', ESX.Math.Round(tax))  
                end
            end            
        end
    end)
end

function RunTax(AllUser)
    CarsTax(AllUser)
    Wait(config.TaxInterval)
    GetUsersForTax()
end

GetUsersForTax()