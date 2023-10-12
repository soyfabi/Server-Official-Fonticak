local nightmareMonsters = {
	"enfeebled silencer",
	"weakened frazzlemaw",
	"kroazur"
}
local ThreatenedDreams = Storage.Quest.U11_40.ThreatenedDreams

local threatenedDreamsNightmareMonstersKills = CreatureEvent("ThreatenedDreamsNightmareMonstersKills")
function threatenedDreamsNightmareMonstersKills.onKill(player, target)
	if target:isPlayer() or target:getMaster() then
		return true
	end

	if not isInArray(nightmareMonsters, target:getName():lower()) then
		return true
	end
	
	local enfeebledKills = player:getStorageValue(ThreatenedDreams.Mission02.EnfeebledMission)
	local frazzlemawsKills = player:getStorageValue(ThreatenedDreams.Mission02.FrazzlemawsMission)
	if player:getStorageValue(ThreatenedDreams.Mission02[1]) == 1 then
		if target:getName():lower() == nightmareMonsters[1] then
			if player:getStorageValue(ThreatenedDreams.Mission02.EnfeebledMission) == 200 then
				return false
			end
			Game.sendAnimatedText("+1 Task", player:getPosition(), 102)
			player:setStorageValue(ThreatenedDreams.Mission02.EnfeebledMission, enfeebledKills + 1)
			player:sendTextMessage(MESSAGE_EVENT_ORANGE, "You have already killed ".. enfeebledKills .. "/200.")
		elseif target:getName():lower() == nightmareMonsters[2] then
			if player:getStorageValue(ThreatenedDreams.Mission02.FrazzlemawsMission) == 200 then
				return false
			end
			Game.sendAnimatedText("+1 Task", player:getPosition(), 102)
			player:setStorageValue(ThreatenedDreams.Mission02.FrazzlemawsMission, frazzlemawsKills + 1)
			player:sendTextMessage(MESSAGE_EVENT_ORANGE, "You have already killed ".. frazzlemawsKills .. "/200 Weakened Frazzlemaw.")
		elseif target:getName():lower() == nightmareMonsters[3] then
			Game.sendAnimatedText("+1 Task", player:getPosition(), 102)
			player:setStorageValue(ThreatenedDreams.Mission02.KroazurMission, 1)
			player:setStorageValue(ThreatenedDreams.Mission02.KroazurKill, 1)
		end
	end

	return true
end

threatenedDreamsNightmareMonstersKills:register()

local threatenedDreamsNightmareMonstersKillsL = CreatureEvent("threatenedDreamsNightmareMonstersKillsL")
function threatenedDreamsNightmareMonstersKillsL.onLogin(player)
	player:registerEvent("ThreatenedDreamsNightmareMonstersKills")
	return true
end

threatenedDreamsNightmareMonstersKillsL:register()
