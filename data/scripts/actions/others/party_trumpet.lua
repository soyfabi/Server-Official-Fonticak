local partyTrumpet = Action()

function partyTrumpet.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if fromPosition.x == CONTAINER_POSITION then
	item:transform(6573)
	item:decay()
	player:say("TOOOOOOT!", TALKTYPE_MONSTER_SAY)
	player:getPosition():sendMagicEffect(CONST_ME_SOUND_BLUE)
	else
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to have it in your hands.")
	end
	return true
end

partyTrumpet:id(6572)
partyTrumpet:register()
