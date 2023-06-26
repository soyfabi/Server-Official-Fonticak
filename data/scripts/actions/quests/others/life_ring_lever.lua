local config = {
	bridgePositions = {
		Position(32410, 32232, 10),
		Position(32411, 32232, 10),
		Position(32412, 32232, 10),
		Position(32410, 32231, 10),
		Position(32411, 32231, 10),
		Position(32412, 32231, 10)
	},
	removeCreaturePosition = Position(32409, 32231, 10),
	bridgeID = 5770,
	waterID = 4610
}

local exhaust = {}
local exhaustTime = 2

local othersLifeRing = Action()
function othersLifeRing.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	local tile, thing, creature
	for i = 1, #config.bridgePositions do
		tile = Tile(config.bridgePositions[i])
		if tile then
			thing, creature = tile:getItemById(item.itemid == 2772 and config.waterID or config.bridgeID), tile:getTopCreature()
			if thing then
				thing:transform(item.itemid == 2772 and config.bridgeID or config.waterID)
			end

			if creature then
				creature:teleportTo(config.removeCreaturePosition)
			end
		end
	end
	exhaust[playerId] = currentTime + exhaustTime
	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

othersLifeRing:aid(40290)
othersLifeRing:register()