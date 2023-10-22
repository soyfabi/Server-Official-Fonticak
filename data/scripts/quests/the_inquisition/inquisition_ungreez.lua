local ungreezKill = CreatureEvent("UngreezKill")
function ungreezKill.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end

	if targetMonster:getName():lower() ~= 'ungreez' then
		return true
	end

	local player = creature:getPlayer()
	local damageMap = target:getDamageMap()
	for key, value in pairs(damageMap) do
		local attackerPlayer = Player(key)
		if attackerPlayer then
			if player:getStorageValue(Storage.TheInquisition.Questline) == 18 then
				-- The Inquisition Questlog- 'Mission 6: The Demon Ungreez'
				player:setStorageValue(Storage.TheInquisition.Mission06, 2)
				player:setStorageValue(Storage.TheInquisition.Questline, 19)
			end
		end
	end
	return true
end

ungreezKill:register()


local ungreezKillL = CreatureEvent("UngreezKillL")
function ungreezKillL.onLogin(player)
	player:registerEvent("UngreezKill")
	return true
end

ungreezKillL:register()
