local exit = MoveEvent()

function exit.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(Position(32566, 31959, 1))
	player:setDirection(DIRECTION_SOUTH)
	return true
end

exit:position(Position(32486, 31927, 7), Position(32487, 31927, 7), Position(32486, 31928, 7), Position(32487, 31928, 7))
exit:register()
