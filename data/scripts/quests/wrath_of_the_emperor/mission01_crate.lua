local condition = Condition(CONDITION_OUTFIT)
condition:setOutfit({lookTypeEx = 11328})
condition:setTicks(-1)

local exhaust = {}
local exhaustTime = 30

local wrathEmperorMiss1Crate = Action()
function wrathEmperorMiss1Crate.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	if player:getStorageValue(Storage.WrathoftheEmperor.Questline) == 2 then
		player:say("You remove its top and pull the crate over yourself. Inside it is stifling and you can barely see a thing when looking outward.", TALKTYPE_MONSTER_SAY)
		player:addCondition(condition)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		exhaust[playerId] = currentTime + exhaustTime
	end
	return true
end

wrathEmperorMiss1Crate:id(11328)
wrathEmperorMiss1Crate:register()
