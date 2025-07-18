ESX = exports["es_extended"]:getSharedObject()


RegisterServerEvent("butcher:giveItems")
AddEventHandler("butcher:giveItems", function(model)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        print("[Butcher] FEHLER: Spieler nicht gefunden")
        return
    end

    if Config.Animals[model] then
        for _, v in pairs(Config.Animals[model].items) do
            xPlayer.addInventoryItem(v.item, v.count)
            print(("[Butcher] %s erhält %dx %s"):format(xPlayer.getName(), v.count, v.item))
        end
        TriggerClientEvent('esx:showNotification', source, "~g~Du hast Materialien erhalten.")
    else
        print("[Butcher] Tiermodell NICHT gefunden: " .. tostring(model))
        TriggerClientEvent('esx:showNotification', source, "~r~Fehler: Tiermodell unbekannt.")
    end
end)
