local blackKnightKill = CreatureEvent("BlackKnightDeath")
function blackKnightKill.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	local player = killer:getPlayer()
	if player:getStorageValue(Storage.SecretService.AVINMission04) == 1 then
		player:setStorageValue(Storage.SecretService.AVINMission04, 2)
	end
	return true
end

blackKnightKill:register()
