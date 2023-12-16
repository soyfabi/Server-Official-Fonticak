local cultsOfTibiaDoor = Action()
function cultsOfTibiaDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if Position(32688, 31543, 9) == item:getPosition() then
		if player:getStorageValue(Storage.CultsOfTibia.Barkless.TrialAccessDoor) == 1 then
			player:teleportTo(Position(32687, 31543, 9))
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The door seems to be sealed against unwanted intruders.")
		end
	end
	return true
end

cultsOfTibiaDoor:uid(22506)
cultsOfTibiaDoor:register()