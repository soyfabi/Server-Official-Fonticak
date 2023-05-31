local condition = Condition(CONDITION_OUTFIT)
condition:setTicks(5 * 60 * 1000) -- should be 5 minutes
condition:setOutfit({lookType = 66}) -- dwarf geomancer looktype

local theThievesKit = Action()
function theThievesKit.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:addCondition(condition)
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	player:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have 5 minutes of dwarf outfit.")
	item:remove()
	return true
end

theThievesKit:id(7865)
theThievesKit:register()