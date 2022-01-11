AddEventHandler("playerSpawned", function(spawn)
  TriggerEvent("esx_welcome:notify", "CHAR_MP_FM_CONTACT", 1, "MALLUESPORTS OFFICIAL ", false, "~b~WELCOME TO MALLUESPORTS RP")
end)

RegisterNetEvent("esx_welcome:notify")
AddEventHandler("esx_welcome:notify", function(icon, type, sender, title, text)
    Citizen.CreateThread(function()
		Wait(1)
		SetNotificationTextEntry("STRING");
		AddTextComponentString(text);
		SetNotificationMessage(icon, icon, true, type, sender, title, text);
		DrawNotification(false, true);
    end)
end)


---PNJ PARKINGCENTRL------------

local v1 = vector3(254.41, -782.76, 31.80)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local distance = 15

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < distance then
            Draw3DText(v1.x,v1.y,v1.z, "T'as un blem ?")
        end
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("csb_rashcosvki")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "csb_rashcosvki", 254.41, -782.76, 29.80, 48.98, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
end)