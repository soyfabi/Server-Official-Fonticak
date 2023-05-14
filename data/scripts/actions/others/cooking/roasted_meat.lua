local roastedMeat = Action()

function roastedMeat.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 1998 then -- campfire
		item:transform(22187) -- roasted meat
		toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are roasting the fresh and bloody meat over the fire. Soon it smells appetizing.")
	end
	return true
end

roastedMeat:id(22186)
roastedMeat:register()
