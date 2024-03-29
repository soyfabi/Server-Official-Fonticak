local servants = {
	['golden servant replica'] = {
		storage = GlobalStorage.ForgottenKnowledge.GoldenServant,
		playerStorage = Storage.ForgottenKnowledge.GoldenServantCounter
	},
	['diamond servant replica'] = {
		storage = GlobalStorage.ForgottenKnowledge.DiamondServant,
		playerStorage = Storage.ForgottenKnowledge.DiamondServantCounter
	}
}
local replicaServant = CreatureEvent("ReplicaServant")
function replicaServant.onKill(creature, target)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetMonster = target:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local bossConfig = servants[targetMonster:getName():lower()]
	if not bossConfig then
		return true
	end
	
	if bossConfig.storage < 0 then
		setGlobalStorageValue(bossConfig.storage, 0)
	end
	setGlobalStorageValue(bossConfig.storage, getGlobalStorageValue(bossConfig.storage) + 1)
	if getGlobalStorageValue(GlobalStorage.ForgottenKnowledge.GoldenServant) >= 5 and getGlobalStorageValue(GlobalStorage.ForgottenKnowledge.DiamondServant) >= 5 then
		if not Tile(Position(32815, 32870, 13)):getItemById(10840) then
			local teleport = Game.createItem(10840, 1, Position(32815, 32870, 13))
			if teleport then
				teleport:setActionId(26665)
			end
		end
	end
	if player:getStorageValue(bossConfig.playerStorage) < 0 then
		player:setStorageValue(bossConfig.playerStorage, 0)
	end
	player:setStorageValue(bossConfig.playerStorage, player:getStorageValue(bossConfig.playerStorage) + 1)
	return true
end
replicaServant:register()

local login = CreatureEvent("ReplicaServantLogin")

function login.onLogin(player)
    player:registerEvent("ReplicaServant")
    return true
end

login:register()
