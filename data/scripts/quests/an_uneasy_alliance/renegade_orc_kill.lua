local renegadeOrcKill = CreatureEvent("RenegadeOrcKill")
function renegadeOrcKill.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end
	if targetMonster:getName():lower() ~= "renegade orc" then
		return true
	end
	local player = creature:getPlayer()
	if player:getStorageValue(Storage.Quest.U8_54.AnUneasyAlliance.QuestDoor) == 0 then
		player:setStorageValue(Storage.Quest.U8_54.AnUneasyAlliance.QuestDoor, 1)
		player:setStorageValue(Storage.Quest.U8_54.AnUneasyAlliance.TheWrathoftheKahn, 2)
		player:say("You just killed him Renegade Orc.")
	end
	return true
end

renegadeOrcKill:register()

local renegadeOrcKillL = CreatureEvent("renegadeOrcKillL")
function renegadeOrcKillL.onLogin(player)
	player:registerEvent("RenegadeOrcKill")
	return true
end

renegadeOrcKillL:register()
