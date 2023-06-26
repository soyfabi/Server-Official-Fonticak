local othersTriangle = Action()

local exhaust = {}
local exhaustTime = 2

function othersTriangle.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end

	local tile = Tile(Position({x = 32566, y = 32119, z = 7}))
	if item.itemid == 2772 then
		if tile:getItemById(1270) then
			tile:getItemById(1270):remove()
			item:transform(2773)
		else
			Game.createItem(1270, 1, {x = 32566, y = 32119, z = 7})
		end
	else
		Game.createItem(1270, 1, {x = 32566, y = 32119, z = 7})
		item:transform(2772)
	end
	exhaust[playerId] = currentTime + exhaustTime
	return true
end

othersTriangle:uid(50023)
othersTriangle:register()