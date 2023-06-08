local doorShive1 = Action()

function doorShive1.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local position = player:getPosition()
	if position.y == toPosition.y then
		return false
	end

	toPosition.y = position.y > toPosition.y and toPosition.y - 1 or toPosition.y + 1
	player:teleportTo(toPosition)
	toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

doorShive1:id(13278, 13279, 13280, 13281, 13282, 13283)
doorShive1:register()

local doorShive2 = Action()

function doorShive2.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local position = player:getPosition()
	if position.x == toPosition.x then
		return false
	end

	toPosition.x = position.x > toPosition.x and toPosition.x - 1 or toPosition.x + 1
	player:teleportTo(toPosition)
	toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

doorShive2:id(13290, 13291, 13292, 13293, 13294)
doorShive2:register()

