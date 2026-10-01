fx_version 'cerulean'
game 'gta5'

description 'Phone System for FiveM using ESX Legacy and ox_inventory'
version '1.0.0'

author 'Your Name'

dependency 'es_extended'

dependency 'ox_inventory'

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

shared_scripts {
    'config.lua'
}