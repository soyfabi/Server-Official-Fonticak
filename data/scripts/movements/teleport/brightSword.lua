local brightSword = MoveEvent()

function brightSword.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(Position(32619, 32249, 8))
	player:setDirection(DIRECTION_WEST)
	return true
end

brightSword:type("stepin")
brightSword:aid(5634)
brightSword:register()
