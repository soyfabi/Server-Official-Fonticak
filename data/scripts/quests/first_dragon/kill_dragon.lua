local killDragon = CreatureEvent("Kill Dragon")

function killDragon.onKill(player, target)
	if target:isPlayer() or target:getMaster() then
		return true
	end
	if target:getName():lower() == "dragon" or target:getName():lower() == "dragon hatchling" then
		local storage = player:getStorageValue(Storage.FirstDragon.DragonCounter)
		if storage >= 0 and storage < 200 then
			player:setStorageValue(Storage.FirstDragon.DragonCounter, player:getStorageValue(Storage.FirstDragon.DragonCounter) + 1)
		end
	end
	if player:getStorageValue(Storage.FirstDragon.TazhadurTimer) >= os.time() then
		return true
	end
	return true
end

killDragon:register()

local killDragonL = CreatureEvent("killDragonL")
function killDragonL.onLogin(player)
	player:registerEvent("Kill Dragon")
	return true
end

killDragonL:register()
