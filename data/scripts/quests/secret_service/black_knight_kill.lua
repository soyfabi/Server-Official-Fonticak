local blackKnightKill = CreatureEvent("BlackKnightKill")
function blackKnightKill.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end

	if targetMonster:getName():lower() ~= "black knight" then
		return true
	end

	local player = creature:getPlayer()
	if player:getStorageValue(Storage.SecretService.AVINMission04) == 1 then
		player:setStorageValue(Storage.SecretService.AVINMission04, 2)
	end

	return true
end

blackKnightKill:register()

local bk = CreatureEvent("BlackKnightKillLogin")
function bk.onLogin(player)
	player:registerEvent("BlackKnightKill")
	return true
end
bk:register()
