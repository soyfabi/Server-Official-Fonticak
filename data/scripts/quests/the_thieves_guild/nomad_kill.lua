local creatureevent = CreatureEvent("NomadKill")

function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	local player = killer:getPlayer()
	
	if player:getStorageValue(Storage.ThievesGuild.Mission04) == 3 then
		player:setStorageValue(Storage.ThievesGuild.Mission04, 4)
	end
	return true
end

creatureevent:register()
