local config = {
	[42751] = {position = Position(33021, 31536, 4)},
	[42752] = {position = Position(33022, 31536, 6)},
}

local NewFrontier = Action()

local exhaust = {}
local exhaustTime = 3
 
function NewFrontier.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)

	local NewFrontier = config[item.actionid]
	if not NewFrontier then
		return true
	end
	
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	player:teleportTo(NewFrontier.position, true)
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	
	


	exhaust[playerId] = currentTime + exhaustTime
    return true
end

for index, value in pairs(config) do
	NewFrontier:aid(index)
end

NewFrontier:register()
