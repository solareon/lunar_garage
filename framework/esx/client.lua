if GetResourceState('es_extended') ~= 'started' then return end

Framework = { name = 'es_extended' }
local sharedObject = exports['es_extended']:getSharedObject()

AddEventHandler('esx:setPlayerData', function(key, val, last)
    if GetInvokingResource() == 'es_extended' then
        sharedObject.playerData[key] = val
        if OnPlayerData then
            OnPlayerData(key, val, last)
        end
    end
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    sharedObject.playerData = xPlayer
    sharedObject.playerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    sharedObject.playerLoaded = false
    sharedObject.playerData = {}
end)

Framework.isPlayerLoaded = sharedObject.IsPlayerLoaded

---@diagnostic disable-next-line: duplicate-set-field
Framework.getJob = function()
    if not Framework.isPlayerLoaded() then
        return false
    end

    return sharedObject.playerData.job.name
end

Framework.hasItem = function(name)
    local playerData = sharedObject.getPlayerData()
    for k,v in ipairs(playerData.inventory) do
        if v.name == name then
            return true
        end
    end
    return false
end

Framework.spawnVehicle = sharedObject.Game.SpawnVehicle

Framework.spawnLocalVehicle = sharedObject.Game.SpawnLocalVehicle

Framework.deleteVehicle = sharedObject.Game.DeleteVehicle

Framework.getPlayersInArea = sharedObject.Game.GetPlayersInArea