local bosses = {
	["brokul"] = {storage = Storage.TheSecretLibrary.LiquidDeath},
}

local BrokulKilled = CreatureEvent("SecretLibraryKillBrokul")
function BrokulKilled.onKill(player, target)
	local targetMonster = target:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end
	local bossConfig = bosses[targetMonster:getName():lower()]
	if not bossConfig then
		return true
	end
	for key, value in pairs(targetMonster:getDamageMap()) do
		local attackerPlayer = Player(key)
		if attackerPlayer then
			if bossConfig.storage then
				if attackerPlayer:getStorageValue(Storage.TheSecretLibrary.LiquidDeath) == 11 then
					attackerPlayer:setStorageValue(bossConfig.storage, 12)
				end
			end
		end
	end
	return true
end
BrokulKilled:register()

local boss = CreatureEvent("LoginBrokul")
function boss.onLogin(player)
	player:registerEvent("SecretLibraryKillBrokul")
	return true
end
boss:register()
