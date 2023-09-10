local templeScroll = Action()

function templeScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPzLocked() and not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
		player:teleportTo(getTownTemplePosition(player:getTown():getId()))
		item:remove()
		Position(fromPosition):sendMagicEffect(CONST_ME_TELEPORT)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You just used a Teleport Scroll and were teleported to your hometown.")
	else
		player:sendCancelMessage("You can't use this when you're in a fight.")
		Position(fromPosition):sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

templeScroll:id(25718)
templeScroll:register()
