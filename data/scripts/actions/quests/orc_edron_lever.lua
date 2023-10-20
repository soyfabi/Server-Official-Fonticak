local othersOrcEdron = Action()

local exhaust = {}
local exhaustTime = 3

function othersOrcEdron.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local playerId = player:getId()
    local currentTime = os.time()
    
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
        return true
    end
    
    local tile = Tile(Position(33171, 31897, 8))
    
    local itemsToRemove = tile:getItems()
    
    for _, itemInTile in ipairs(itemsToRemove) do
        if itemInTile:getId() ~= 1772 then
            itemInTile:remove()
            Position(33171, 31897, 8):sendMagicEffect(CONST_ME_POFF)
        end
    end
    
    if item.itemid == 2772 then
        local stoneItem = tile:getItemById(1772)
        if stoneItem then
            stoneItem:remove()
            item:transform(2773)
        end
    else
		local creatureInTile = tile:getTopCreature()
		if creatureInTile then
			if creatureInTile:isMonster() then
				-- Si es un monstruo, realiza acciones específicas para monstruos
				tile:relocateTo(Position(33171, 31898, 8), true)
				creatureInTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				creatureInTile:setDirection(DIRECTION_SOUTH)
			elseif creatureInTile:isPlayer() then
				-- Si es un jugador, realiza acciones específicas para jugadores
				tile:relocateTo(Position(33171, 31898, 8), true)
				creatureInTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				creatureInTile:setDirection(DIRECTION_SOUTH)
			end
		end
        Game.createItem(1772, 1, Position(33171, 31897, 8))
        item:transform(2772)
    end
    
    exhaust[playerId] = currentTime + exhaustTime
    return true
end

othersOrcEdron:uid(1017)
othersOrcEdron:register()