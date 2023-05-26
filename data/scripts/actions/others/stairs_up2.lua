local upFloorIds = {17230}

local teleport = Action()

function teleport.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isInArray(upFloorIds, item.itemid) then
		fromPosition:moveUpstairs()
		fromPosition.x = fromPosition.x - 1
		fromPosition.y = fromPosition.y - 1
		player:setDirection(DIRECTION_WEST)
	else
		fromPosition.z = fromPosition.z + 1
	end
	player:teleportTo(fromPosition, false)
	return true
end

teleport:id(17230)
teleport:register()

