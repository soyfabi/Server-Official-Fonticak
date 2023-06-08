local config = {
	[9238] = Position(33456, 31346, 8),
	[9239] = Position(33199, 31978, 8)
}

local grayBeachVortex = MoveEvent()

local exhaust = {}
local exhaustTime = 2

function grayBeachVortex.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		player:teleportTo(fromPosition, true)
		return true
	end

	local targetPosition = config[item.uid]
	if not targetPosition then
		return true
	end
	exhaust[playerId] = currentTime + exhaustTime
	player:teleportTo(targetPosition)
	targetPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You dive into the vortex to swim below the rocks to the other side of the cave.")
	return true
end

grayBeachVortex:type("stepin")

for index, value in pairs(config) do
	grayBeachVortex:uid(index)
end

grayBeachVortex:register()
