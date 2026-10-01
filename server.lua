local ESX = exports['es_extended']:getSharedObject()

-- Send message
RegisterNetEvent('phone:sendMessage')
AddEventHandler('phone:sendMessage', function(receiver, message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local receiverPlayer = ESX.GetPlayerFromId(receiver)
    
    if xPlayer and receiverPlayer then
        MySQL.Async.execute('INSERT INTO phone_messages (sender_id, receiver_id, message) VALUES (@sender_id, @receiver_id, @message)', {
            ['@sender_id'] = xPlayer.identifier,
            ['@receiver_id'] = receiverPlayer.identifier,
            ['@message'] = message
        }, function(rowsChanged)
            TriggerClientEvent('phone:messageSent', _source, receiver, message)
        end)
    end
end)

-- Add contact
RegisterNetEvent('phone:addContact')
AddEventHandler('phone:addContact', function(name, number)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer then
        MySQL.Async.execute('INSERT INTO phone_contacts (owner_id, name, number) VALUES (@owner_id, @name, @number)', {
            ['@owner_id'] = xPlayer.identifier,
            ['@name'] = name,
            ['@number'] = number
        }, function(rowsChanged)
            TriggerClientEvent('phone:contactAdded', _source, name, number)
        end)
    end
end)

-- Call
RegisterNetEvent('phone:call')
AddEventHandler('phone:call', function(number)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer then
        MySQL.Async.fetchScalar('SELECT identifier FROM users WHERE phone_number = @number', {
            ['@number'] = number
        }, function(receiverId)
            if receiverId then
                TriggerClientEvent('phone:call', _source, number)
                TriggerClientEvent('phone:call', receiverId, xPlayer.get('phone_number'))
            else
                TriggerClientEvent('phone:callFailed', _source, 'Number not found')
            end
        end)
    end
end)