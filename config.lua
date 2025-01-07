Config = {}

-- Enable test mode to increase jam probabilities for all weapons / Habilitar modo de prueba para aumentar las probabilidades de trabado
Config.TestMode = false -- Cambiar a false para deshabilitar / Set to false to disable

-- Probabilidades base de trabado según arma específica / Base jam probabilities by specific weapon
Config.WeaponJamChances = {
    -- Pistols / Pistolas
    ['weapon_pistol'] = 5,
    ['weapon_combatpistol'] = 4,
    ['weapon_pistol50'] = 3,
    ['weapon_snspistol'] = 7,
    ['weapon_heavypistol'] = 6,
    ['weapon_vintagepistol'] = 6,
    ['weapon_ceramicpistol'] = 8,
    ['weapon_marksmanpistol'] = 10,
    ['weapon_revolver'] = 2,
    ['weapon_revolver_mk2'] = 2,
    ['weapon_doubleaction'] = 3,
    ['weapon_navyrevolver'] = 4,
    ['weapon_flaregun'] = 1,

    -- Submachine Guns / Subfusiles
    ['weapon_microsmg'] = 5,
    ['weapon_smg'] = 4,
    ['weapon_smg_mk2'] = 4,
    ['weapon_assaultsmg'] = 3,
    ['weapon_combatpdw'] = 5,
    ['weapon_machinepistol'] = 7,
    ['weapon_minismg'] = 6,

    -- Rifles / Rifles de asalto
    ['weapon_assaultrifle'] = 3,
    ['weapon_assaultrifle_mk2'] = 3,
    ['weapon_carbinerifle'] = 2,
    ['weapon_carbinerifle_mk2'] = 2,
    ['weapon_advancedrifle'] = 2,
    ['weapon_specialcarbine'] = 3,
    ['weapon_specialcarbine_mk2'] = 3,
    ['weapon_bullpuprifle'] = 4,
    ['weapon_bullpuprifle_mk2'] = 4,
    ['weapon_militaryrifle'] = 2,
    ['weapon_heavyrifle'] = 5,
    ['weapon_tacticalrifle'] = 5,

    -- Shotguns / Escopetas
    ['weapon_pumpshotgun'] = 5,
    ['weapon_pumpshotgun_mk2'] = 5,
    ['weapon_sawnoffshotgun'] = 6,
    ['weapon_assaultshotgun'] = 4,
    ['weapon_bullpupshotgun'] = 4,
    ['weapon_musket'] = 7,
    ['weapon_heavyshotgun'] = 3,
    ['weapon_dbshotgun'] = 8,
    ['weapon_autoshotgun'] = 4,
    ['weapon_combatshotgun'] = 5,

    -- Sniper Rifles / Rifles de francotirador
    ['weapon_sniperrifle'] = 2,
    ['weapon_heavysniper'] = 1,
    ['weapon_heavysniper_mk2'] = 1,
    ['weapon_marksmanrifle'] = 3,
    ['weapon_marksmanrifle_mk2'] = 3,

    -- Machine Guns / Ametralladoras ligeras
    ['weapon_mg'] = 3,
    ['weapon_combatmg'] = 2,
    ['weapon_combatmg_mk2'] = 2,
    ['weapon_gusenberg'] = 4,

    -- Heavy Weapons / Armas pesadas
    ['weapon_rpg'] = 0,
    ['weapon_grenadelauncher'] = 0,
    ['weapon_grenadelauncher_smoke'] = 0,
    ['weapon_minigun'] = 0,
    ['weapon_firework'] = 0,
    ['weapon_railgun'] = 0,
    ['weapon_hominglauncher'] = 0,
    ['weapon_compactlauncher'] = 0,

    -- Thrown Weapons / Armas arrojadizas
    ['weapon_grenade'] = 0,
    ['weapon_stickybomb'] = 0,
    ['weapon_proxmine'] = 0,
    ['weapon_pipebomb'] = 0,
    ['weapon_snowball'] = 0,
    ['weapon_bzgas'] = 0,
    ['weapon_molotov'] = 0,
    ['weapon_flare'] = 0,

    -- Melee Weapons / Armas cuerpo a cuerpo
    ['weapon_knife'] = 0,
    ['weapon_nightstick'] = 0,
    ['weapon_hammer'] = 0,
    ['weapon_bat'] = 0,
    ['weapon_golfclub'] = 0,
    ['weapon_crowbar'] = 0,
    ['weapon_bottle'] = 0,
    ['weapon_dagger'] = 0,
    ['weapon_hatchet'] = 0,
    ['weapon_knuckle'] = 0,
    ['weapon_machete'] = 0,
    ['weapon_flashlight'] = 0,
    ['weapon_switchblade'] = 0,
    ['weapon_poolcue'] = 0,
    ['weapon_wrench'] = 0,
    ['weapon_battleaxe'] = 0,
    ['weapon_stone_hatchet'] = 0,

    -- Special Weapons / Armas especiales
    ['weapon_raypistol'] = 3,
    ['weapon_raycarbine'] = 3,
    ['weapon_rayminigun'] = 0,

    -- Default fallback / Configuración por defecto para armas no listadas
    ['default'] = 3
}

-- Ajuste de probabilidad según el deterioro (deterioro máximo 100%) / Probability adjustment based on deterioration
Config.DeteriorationMultiplier = 0.5 -- Porcentaje adicional por cada 10% de deterioro / Additional percentage per 10% deterioration

-- Configuración del destrabe / Unjamming configuration
Config.RequiredKeyPresses = 10 -- Veces que se debe presionar [E] / Number of times [E] must be pressed
Config.ProgressDuration = 3000 -- Duración de la barra de progreso (ms) / Duration of the progress bar in milliseconds (if used)
