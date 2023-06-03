local childrenMission3 = Action()
function childrenMission3.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.ChildrenoftheRevolution.Questline) == 9 then
		player:setStorageValue(Storage.ChildrenoftheRevolution.Questline, 10)
		player:addItem(10183, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a flask of poison.")
	elseif player:getStorageValue(Storage.ChildrenoftheRevolution.StrangeSymbols) == 2 then
		player:setStorageValue(Storage.ChildrenoftheRevolution.StrangeSymbols, 3)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(10189, 1)
		player:say("Somewhere between flasks and dust the shelf also holds a gooey jar of extra greasy oil.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
	end
	return true
end

childrenMission3:uid(3164, 3165)
childrenMission3:register()
