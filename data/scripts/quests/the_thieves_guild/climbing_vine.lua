local config = {
	[12501] = {pos = Position(32336, 31813, 6), direction = DIRECTION_NORTH}, -- to the room
	[12502] = {pos = Position(32337, 31815, 7), direction = DIRECTION_SOUTH} -- outside the room
}

local theThievesVine = Action()

local exhaust = {}
local exhaustTime = 2

function theThievesVine.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetPosition = config[item.actionid]
	if not targetPosition then
		return true
	end
	
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	if player:isPzLocked() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can not enter a protection zone after attacking another player.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end
		player:teleportTo(targetPosition.pos)
		player:setDirection(targetPosition.direction)
		exhaust[playerId] = currentTime + exhaustTime

	return true
end

theThievesVine:aid(12501,12502)
theThievesVine:register()