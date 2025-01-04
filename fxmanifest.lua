
fx_version 'cerulean'
game 'gta5'

author 'Nitro'
description 'Sistema optimizado de trabado de armas para QBox con soporte para idiomas y deterioro'
version '2.0.0'
lua54 'yes' -- Habilita Lua 5.4 para este recurso

shared_scripts {
    '@ox_lib/init.lua',  -- Inicializa ox_lib
    'locales/*.lua',  -- Archivos de idioma
    'config.lua'      -- Configuración
}

client_scripts {
    'client/main.lua' -- Lógica principal
}
