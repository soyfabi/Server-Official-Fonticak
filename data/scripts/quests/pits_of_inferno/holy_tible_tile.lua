local destinations = {
	[2000] = Position(32791, 32331, 10),
	[2001] = Position(32791, 32327, 10)
}

local holyTibleTile = MoveEvent()

local exhaust = {}
local exhaustTime = 2

function holyTibleTile.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
		player:teleportTo(fromPosition, true)
		return true
	end

	if player:getItemCount(2836) < 1 then
		player:teleportTo(Position(32791, 32333, 10))
		player:say("You need the holy Tible.")
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	player:teleportTo(destinations[item.uid])
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	exhaust[playerId] = currentTime + exhaustTime
	return true
end

holyTibleTile:type("stepin")

for index, value in pairs(destinations) do
	holyTibleTile:uid(index)
end

holyTibleTile:register()
