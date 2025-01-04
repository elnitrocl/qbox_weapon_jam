-- Variables to track weapon malfunction / Variables para rastrear trabado de armas
local Locale = Locales['es'] -- Change to 'en' for English / Cambiar a 'en' para inglés
local isWeaponJammed = false
local jammedWeapon = nil
local keyPressCount = 0 -- Counter for key presses / Contador de pulsaciones
Locale = Locales or {}
-- Function to calculate jam chance / Función para calcular probabilidad de trabado
local function CalculateJamChance(baseChance, durability)
    return baseChance + ((100 - durability) * Config.DeteriorationMultiplier / 10)
end

local function CalculateJamChance(baseChance, durability)
    if Config.TestMode then
        return 100 -- Si está en modo de prueba, fuerza el trabado al 100%
    end
    return baseChance + ((100 - durability) * Config.DeteriorationMultiplier / 10)
end

-- Thread to detect shooting and apply jams / Hilo para detectar disparos y aplicar trabado
CreateThread(function()
    while true do
        Wait(0)
        if isWeaponJammed then
            DisablePlayerFiring(PlayerPedId(), true) -- Disable firing if the weapon is jammed / Deshabilitar disparos si el arma está trabada
        else
            local currentWeapon = exports.ox_inventory:getCurrentWeapon()
            if currentWeapon then
                local ped = PlayerPedId()
                if IsPedShooting(ped) then
                    local weaponName = currentWeapon.name -- Nombre del arma en ox_inventory (e.g., weapon_combatpistol)
                    local durability = currentWeapon.metadata.durability or 100 -- Deterioro del arma

                    local baseChance = Config.WeaponJamChances[weaponName] or Config.WeaponJamChances['default']
                    local jamChance = CalculateJamChance(baseChance, durability)

                    -- Check if the weapon jams / Verificar si el arma se traba
                    if math.random(1, 100) <= jamChance then
                        isWeaponJammed = true
                        jammedWeapon = weaponName
                        TriggerEvent('qbox-weaponjam:weaponJammed', weaponName)
                    end

                    -- Notify if the weapon is deteriorating / Notificar si el arma se está deteriorando
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
end)

-- Event for weapon jam / Evento para trabado de armas
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
end)

-- Thread to handle unjamming weapons / Hilo para manejar destrabe de armas
CreateThread(function()
    while true do
        Wait(0)
        if isWeaponJammed and jammedWeapon then
            if IsControlJustPressed(0, 38) then -- E key / Tecla E
                local ped = PlayerPedId()
                keyPressCount = keyPressCount + 1 -- Increment key press count / Incrementar contador de pulsaciones

                -- Show notification with progress / Mostrar notificación de progreso
                lib.notify({
                    id = 'unjam_progress',
                    title = Locale['notification_title'],
                    description = Locale['unjamming_progress'], -- Usar el mensaje desde locales
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

                -- Play animation / Reproducir animación
                RequestAnimDict("mp_arresting")
                while not HasAnimDictLoaded("mp_arresting") do
                    Wait(0)
                end
                if not IsEntityPlayingAnim(ped, "mp_arresting", "a_uncuff", 3) then
                    TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, -8.0, -1, 49, 0, false, false, false)
                end

                -- If enough presses, unjam the weapon / Si hay suficientes pulsaciones, destraba el arma
                if keyPressCount >= Config.RequiredKeyPresses then
                    isWeaponJammed = false
                    jammedWeapon = nil
                    keyPressCount = 0
                    ClearPedTasks(ped)

                    -- Success notification / Notificación de éxito
                    lib.notify({
                        id = 'weapon_unjammed',
                        title = Locale['notification_title'],
                        description = Locale['weapon_unjammed'],
                        position = 'top-right',
                        style = {
                            backgroundColor = '#006400', -- Dark green / Verde oscuro
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
end)
