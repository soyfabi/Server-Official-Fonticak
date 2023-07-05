local killStorage = 884734
local deathStorage = 884735
local toMostDamage = true
local toKiller = true

local event = CreatureEvent("KillandCount")
function event.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
    if not creature:isPlayer() then return true end
    if creature then
        if killer and killer:isPlayer() and toKiller then
            local killAmount = killer:getStorageValue(killStorage)
            if killAmount == -1 then killAmount = 0 end
            killer:setStorageValue(killStorage, killAmount + 1)
        end
        if mostDamageKiller and mostDamageKiller:isPlayer() and toMostDamageKiller then
            local killAmount = mostDamageKiller:getStorageValue(killStorage)
            if killAmount == -1 then killAmount = 0 end
            mostDamageKiller:setStorageValue(killStorage, killAmount + 1)
        end
        local deathAmount = creature:getStorageValue(deathStorage)
        if deathAmount == -1 then deathAmount = 0 end
        creature:setStorageValue(deathStorage, deathAmount + 1)
    end
    return true
end

event:register()


local eventLogin = CreatureEvent("KillandCountLogin")
function eventLogin.onLogin(player)
	player:registerEvent("KillandCount")
	return true
end

eventLogin:register()



