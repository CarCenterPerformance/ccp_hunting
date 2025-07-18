ESX = exports["es_extended"]:getSharedObject()


local targetAnimal = nil
local isButchering = false

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        targetAnimal = GetClosestDeadAnimal(coords)

        if targetAnimal and not isButchering then
            local animalCoords = GetEntityCoords(targetAnimal)
            if #(coords - animalCoords) < 2.0 then
                DrawText3D(animalCoords.x, animalCoords.y, animalCoords.z + 0.5, "[~g~E~s~] Tier ausnehmen")

                if IsControlJustReleased(0, 38) then
                    local weapon = GetSelectedPedWeapon(ped)
                    if Config.AllowedWeapons[weapon] then
                        local model = GetEntityModel(targetAnimal)
                        if Config.Animals[model] then
                            ButcherAnimal(targetAnimal, model)
                        else
                            ESX.ShowNotification("~r~Dieses Tier kann nicht ausgenommen werden.")
                        end
                    else
                        ESX.ShowNotification("~r~Du brauchst ein Messer oder ähnliches!")
                    end
                end
            end
        end
    end
end)

function ButcherAnimal(animal, model)
    isButchering = true
    local ped = PlayerPedId()

    RequestAnimDict("amb@medic@standing@kneel@base")
    while not HasAnimDictLoaded("amb@medic@standing@kneel@base") do
        Wait(10)
    end

    TaskPlayAnim(ped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
    ESX.ShowNotification("~g~Du nimmst das Tier aus...")

    Wait(5000)

    ClearPedTasks(ped)

    DeleteEntity(animal)
    TriggerServerEvent("butcher:giveItems", model)
    isButchering = false
end

function GetClosestDeadAnimal(coords)
    local handle, ped = FindFirstPed()
    local success
    local closestPed
    local closestDistance = 2.0
    repeat
        if DoesEntityExist(ped) and IsPedDeadOrDying(ped, true) then
            local model = GetEntityModel(ped)
            if Config.Animals[model] then
                local pedCoords = GetEntityCoords(ped)
                local dist = #(coords - pedCoords)
                if dist < closestDistance then
                    closestDistance = dist
                    closestPed = ped
                end
            end
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return closestPed
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    if onScreen then
        DrawText(_x, _y)
    end
end
