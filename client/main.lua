-- Variables para rastrear trabado de armas / Variables to track weapon malfunction
local Locale = Locales['es'] -- Cambiar a 'en' para inglés / Change to 'en' for English
local isWeaponJammed = false -- Estado de si el arma está trabada / State if the weapon is jammed
local jammedWeapon = nil -- Nombre del arma trabada / Name of the jammed weapon
local keyPressCount = 0 -- Contador de pulsaciones / Counter for key presses
Locale = Locales or {} -- Inicialización de Locales / Initialize Locales

-- Función para calcular probabilidad de trabado / Function to calculate jam probability
local function CalculateJamChance(baseChance, durability)
    if Config.TestMode then
        return 100 -- Si está en modo de prueba, fuerza el trabado al 100% / If in test mode, force 100% jam probability
    end
    return baseChance + ((100 - durability) * Config.DeteriorationMultiplier / 10) -- Fórmula para calcular el trabado / Formula to calculate jamming
end

-- Hilo para detectar disparos y aplicar trabado / Thread to detect shooting and apply jams
CreateThread(function()
    while true do
        Wait(0)
        if isWeaponJammed then
            DisablePlayerFiring(PlayerPedId(), true) -- Deshabilitar disparos si el arma está trabada / Disable firing if the weapon is jammed
        else
            local currentWeapon = exports.ox_inventory:getCurrentWeapon()
            if currentWeapon then
                local ped = PlayerPedId()
                if IsPedShooting(ped) then
                    local weaponName = currentWeapon.name -- Nombre del arma en ox_inventory / Weapon name in ox_inventory
                    local durability = currentWeapon.metadata.durability or 100 -- Deterioro del arma / Weapon durability

                    local baseChance = Config.WeaponJamChances[weaponName] or Config.WeaponJamChances['default']
                    local jamChance = CalculateJamChance(baseChance, durability)

                    -- Verificar si el arma se traba / Check if the weapon jams
                    if math.random(1, 100) <= jamChance then
                        isWeaponJammed = true
                        jammedWeapon = weaponName
                        TriggerEvent('qbox-weaponjam:weaponJammed', weaponName)
                    end

                    -- Notificar si el arma se está deteriorando / Notify if the weapon is deteriorating
                    if durability <= 25 then
                        lib.notify({
                            id = 'deterioration_warning',
                            title = Locale['notification_title'],
                            description = Locale['deterioration_warning'],
                            position = 'top-right',
                            style = {
                                backgroundColor = '#ffcc00',
                                color = '#000000',
                                ['.description'] = {
                                    color = '#000000'
                                }
                            },
                            icon = 'wrench',
                            iconColor = '#ffffff'
                        })
                    end
                end
            end
        end
    end
end) -- Cierre del primer CreateThread / Closing the first CreateThread

-- Evento para trabado de armas / Event for weapon jam
RegisterNetEvent('qbox-weaponjam:weaponJammed', function(weaponName)
    if isWeaponJammed then
        lib.notify({
            id = 'weapon_jammed',
            title = Locale['notification_title'],
            description = Locale['weapon_jammed'],
            position = 'top-right',
            style = {
                backgroundColor = '#ff0000',
                color = '#ffffff',
                ['.description'] = {
                    color = '#ffffff'
                }
            },
            icon = 'exclamation-triangle',
            iconColor = '#ffcc00'
        })
    end
end) -- Cierre del evento / Closing the event

-- Hilo para manejar destrabe de armas / Thread to handle unjamming weapons
CreateThread(function()
    while true do
        Wait(0)
        if isWeaponJammed and jammedWeapon then
            if IsControlJustPressed(0, 38) then -- Tecla E / Key E
                local ped = PlayerPedId()
                keyPressCount = keyPressCount + 1 -- Incrementar contador de pulsaciones / Increment key press count

                -- Mostrar notificación de progreso / Show notification with progress
                lib.notify({
                    id = 'unjam_progress',
                    title = Locale['notification_title'],
                    description = Locale['unjamming_progress'], -- Usar el mensaje desde locales / Use the message from locales
                    position = 'top-right',
                    style = {
                        backgroundColor = '#1e90ff',
                        color = '#ffffff',
                        ['.description'] = {
                            color = '#dcdcdc'
                        }
                    },
                    icon = 'spinner',
                    iconColor = '#ffffff'
                })

                -- Reproducir animación / Play animation
                RequestAnimDict("mp_arresting")
                while not HasAnimDictLoaded("mp_arresting") do
                    Wait(0)
                end
                if not IsEntityPlayingAnim(ped, "mp_arresting", "a_uncuff", 3) then
                    TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, -8.0, -1, 49, 0, false, false, false)
                end

                -- Si hay suficientes pulsaciones, destraba el arma / If enough presses, unjam the weapon
                if keyPressCount >= Config.RequiredKeyPresses then
                    isWeaponJammed = false
                    jammedWeapon = nil
                    keyPressCount = 0
                    ClearPedTasks(ped)

                    -- Notificación de éxito / Success notification
                    lib.notify({
                        id = 'weapon_unjammed',
                        title = Locale['notification_title'],
                        description = Locale['weapon_unjammed'],
                        position = 'top-right',
                        style = {
                            backgroundColor = '#006400', -- Verde oscuro / Dark green
                            color = '#ffffff',
                            ['.description'] = {
                                color = '#dcdcdc'
                            }
                        },
                        icon = 'check-circle',
                        iconColor = '#ffffff'
                    })
                end
            end
        end
    end
end) -- Cierre del segundo CreateThread / Closing the second CreateThread
