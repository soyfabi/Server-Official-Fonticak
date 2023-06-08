local config = {
	[50011] = Position(32636, 31881, 2),
	[50012] = Position(32636, 31881, 7)
}

local elevatorLever = Action()

local exhaust = {}
local exhaustTime = 2

function elevatorLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end

	local targetPosition = config[item.actionid]
	if not targetPosition then
		return true
	end
	
	item:transform(item.itemid == 2772 and 2773 or 2772)

	toPosition.x = toPosition.x - 1
	local creature = Tile(toPosition):getTopCreature()
	if not creature or not creature:isPlayer() then
		return true
	end

	if item.itemid ~= 2772 then
		return true
	end

	creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	creature:teleportTo(targetPosition)
	targetPosition:sendMagicEffect(CONST_ME_TELEPORT)
	exhaust[playerId] = currentTime + exhaustTime
	return true
end

elevatorLever:aid(50011, 50012)
elevatorLever:register()
