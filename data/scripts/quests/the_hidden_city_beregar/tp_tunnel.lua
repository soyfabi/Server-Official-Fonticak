local tp_tunnel = MoveEvent()

function tp_tunnel.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(Position(32637, 31509, 10))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

tp_tunnel:type("stepin")
tp_tunnel:aid(50199)
tp_tunnel:register()
