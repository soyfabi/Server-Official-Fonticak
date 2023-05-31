local bosses = {
	['ushuriel'] = 200,
	['zugurosh'] = 201,
	['madareth'] = 202,
	['latrivan'] = 203,
	['golgordan'] = 203,
	['annihilon'] = 204,
	['hellgorak'] = 205
}

local inquisitionBossKill = CreatureEvent("InquisitionBossKill")
function inquisitionBossKill.onKill(player, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end

	local targetName = targetMonster:getName():lower()
	local bossStorage = bosses[targetName]
	if not bossStorage then
		return true
	end

	local newValue = 2
	if targetName == 'latrivan' or targetName == 'golgordan' then
		newValue = math.max(0, getGlobalStorageValue(bossStorage)) + 1
	end
	setGlobalStorageValue(bossStorage, newValue)

	if newValue == 2 then
		player:say('You now have 10 minutes to exit this room through the teleporter. It will bring you to the next room.', TALKTYPE_MONSTER_SAY)
		addEvent(setGlobalStorageValue, 10 * 60 * 1000, bossStorage, 0)
	end
	return true
end

inquisitionBossKill:register()

local inquisitionBossKillL = CreatureEvent("inquisitionBossKillL")
function inquisitionBossKillL.onLogin(player)
	player:registerEvent("InquisitionBossKill")
	return true
end

inquisitionBossKillL:register()
