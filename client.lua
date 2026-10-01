local ESX = exports['es_extended']:getSharedObject()

-- Phone UI
local phoneUI = {
    visible = false,
    currentMenu = 'home'
}

-- Open phone
RegisterNetEvent('phone:open')
AddEventHandler('phone:open', function()
    if not phoneUI.visible then
        phoneUI.visible = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open',
            menu = phoneUI.currentMenu
        })
    end
end)

-- Close phone
RegisterNetEvent('phone:close')
AddEventHandler('phone:close', function()
    if phoneUI.visible then
        phoneUI.visible = false
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = 'close'
        })
    end
end)

-- Handle NUI callbacks
RegisterNUICallback('phone:close', function(data, cb)
    TriggerEvent('phone:close')
    cb('ok')
end)

-- Handle NUI callbacks for other actions
RegisterNUICallback('phone:action', function(data, cb)
    if data.action == 'sendMessage' then
        TriggerServerEvent('phone:sendMessage', data.receiver, data.message)
    elseif data.action == 'addContact' then
        TriggerServerEvent('phone:addContact', data.name, data.number)
    elseif data.action == 'call' then
        TriggerServerEvent('phone:call', data.number)
    end
    cb('ok')
end)

-- Handle phone item usage
ESX.RegisterUsableItem(Config.PhoneItem, function(source)
    TriggerEvent('phone:open')
end)

-- Handle phone item removal
RegisterNetEvent('phone:remove')
AddEventHandler('phone:remove', function()
    TriggerEvent('phone:close')
end)