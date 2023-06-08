local config = {
	[36489] = {position = Position(33559, 31970, 12), direction = DIRECTION_EAST}, --Glooth
	[42626] = {position = Position(33539, 32014, 6), direction = DIRECTION_EAST}, --Oramond
	[42627] = {position = Position(33491, 31985, 7), direction = DIRECTION_WEST}, --Oramond
	[42630] = {position = Position(33636, 31891, 6), direction = DIRECTION_WEST}, --City
	[42631] = {position = Position(33486, 31982, 7), direction = DIRECTION_WEST}, --City
	[50389] = {position = Position(33651, 31942, 7), direction = DIRECTION_SOUTH} --Glooth
}

local oramondTeleport = MoveEvent()

local exhaust = {}
local exhaustTime = 2

function oramondTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		player:teleportTo(fromPosition)
		return true
	end

	local teleport = config[item.actionid]
	if teleport then
		player:teleportTo(teleport.position)
		player:setDirection(teleport.direction)
		fromPosition:sendMagicEffect(CONST_ME_GREEN_RINGS)
		player:getPosition():sendMagicEffect(CONST_ME_GREEN_RINGS)
		player:say("Slrrp!", TALKTYPE_MONSTER_SAY)
	end
	exhaust[playerId] = currentTime + exhaustTime
	return true
end

oramondTeleport:type("stepin")

for index, value in pairs(config) do
	oramondTeleport:aid(index)
end

oramondTeleport:register()
