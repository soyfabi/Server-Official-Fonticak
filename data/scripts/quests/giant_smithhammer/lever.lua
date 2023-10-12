local lever = Action()

local exhaust = {}
local exhaustTime = 2

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local playerId = player:getId()
    local currentTime = os.time()

    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
        return true
    end

	local position = Position(32780, 32231, 8)
    local tile = Tile(Position(position))

    if not tile then
        player:sendCancelMessage("Error: Invalid tile.")
        return true
    end

    local itemsToRemove = tile:getItems()
    
    for _, itemInTile in ipairs(itemsToRemove) do
        if itemInTile:getId() ~= 389 then
            itemInTile:remove()
			position:sendMagicEffect(CONST_ME_POFF)
        end
    end

    if item.itemid == 2772 and tile:getItemById(389) then
        tile:getItemById(389):remove()
        item:transform(2773)
    elseif item.itemid == 2773 and not tile:getItemById(389) then
        Position(position):hasCreature({x = 32780, y = 32232, z = 8})
        Game.createItem(389, 1, position)
        item:transform(2772)
    end

    exhaust[playerId] = currentTime + exhaustTime
    return true
end

lever:uid(30024)
lever:register()