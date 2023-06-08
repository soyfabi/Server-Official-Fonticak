local destination = {
	[64013] = Position(32958, 32324, 8), --Deep desert
	[64014] = Position(33110, 32386, 7), --Deep desert
}

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = destination[item.actionid]
	if teleport then
		player:teleportTo(teleport)
		fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		teleport:sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

teleport:type("stepin")

for index, value in pairs(destination) do
	teleport:aid(index)
end

teleport:register()
