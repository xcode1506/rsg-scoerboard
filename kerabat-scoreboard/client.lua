local scoreboardOpen = false
local lastRefresh = 0
local refreshCooldown = Config.RefreshInterval or 1500

function ToggleScoreboard()
    scoreboardOpen = not scoreboardOpen
    
    if scoreboardOpen then
        RequestData()
        SendNUIMessage({
            action = 'open',
            config = Config.UI
        })
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(true)
    else
        SendNUIMessage({
            action = 'close'
        })
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
    end
end

function RequestData()
    if GetGameTimer() - lastRefresh < refreshCooldown then
        return
    end
    
    lastRefresh = GetGameTimer()
    
    RSGCore.Functions.TriggerCallback('rsg-scoreboard:getPlayerData', function(data)
        if data then
            TriggerEvent('rsg-scoreboard:updateData', data)
        end
    end)
end

RegisterCommand(Config.ToggleCommand, function()
    ToggleScoreboard()
end, false)

RegisterNetEvent('rsg-scoreboard:toggle')
AddEventHandler('rsg-scoreboard:toggle', function()
    ToggleScoreboard()
end)

CreateThread(function()
    while true do
        Wait(0)
        
        if scoreboardOpen and IsControlJustReleased(0, 0x156F7119) then
            ToggleScoreboard()
            Wait(200)
        end
        
        if scoreboardOpen and IsControlJustReleased(0, 0x760A9C6F) then
            ToggleScoreboard()
            Wait(200)
        end
        
        if scoreboardOpen then
            EnableControlAction(0, 0x8FD015D8, true)
            EnableControlAction(0, 0x7065027D, true)
            EnableControlAction(0, 0xD51B784F, true)
            EnableControlAction(0, 0xF84FA74F, true)
            EnableControlAction(0, 0x05CA7C52, true)
            EnableControlAction(0, 0x07CE1E61, true)
            
            DisableControlAction(0, 0xE8373D7E, true)
            DisableControlAction(0, 0xD7CBC2D3, true)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(100)
        if scoreboardOpen and (GetGameTimer() - lastRefresh >= refreshCooldown) then
            RequestData()
        end
    end
end)

RegisterNetEvent('rsg-scoreboard:updateData', function(data)
    SendNUIMessage({
        action = 'update',
        payload = data
    })
end)

RegisterNUICallback('close', function(_, cb)
    scoreboardOpen = false
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    cb('ok')
end)

function IsScoreboardOpen()
    return scoreboardOpen
end

exports('IsScoreboardOpen', function()
    return scoreboardOpen
end)

AddEventHandler('onResourceStop', function(res)
    if res == GetCurrentResourceName() then
        if scoreboardOpen then
            SendNUIMessage({ action = 'close' })
        end
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
    end
end)

Citizen.CreateThread(function()
    while not RSGCore do
        RSGCore = exports['rsg-core']:GetCoreObject()
        Wait(100)
    end
end)