local config = {
	[52034] = {pos_wall = Position(32259, 31891, 10), wall_id = 2129, text = "The wall has disappeared, you have 2 minutes to pass or it will close again."},
	[52035] = {pos_wall = Position(32259, 31890, 10), wall_id = 2129, text = "The wall has disappeared, you have 2 minutes to pass or it will close again."},
	[52036] = {pos_wall = Position(32266, 31860, 11), wall_id = 2129, text = "The wall has disappeared."},
}

local lever = Action()

local exhaust = {}
local exhaustTime = 1
 
function lever.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)

	local leverwall = config[item.actionid]
	if not leverwall then
		return true
	end
	
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end

    local tile = Tile(leverwall.pos_wall)
    if tile then
        local stone = tile:getItemById(leverwall.wall_id)
        if stone then
        stone:remove()
        leverwall.pos_wall:sendMagicEffect(CONST_ME_POFF)
        player:say(leverwall.text)
        Item(item.uid):transform(2773)
    else
        Game.createItem(leverwall.wall_id, 1, leverwall.pos_wall)
        leverwall.pos_wall:sendMagicEffect(CONST_ME_TELEPORT)
        Item(item.uid):transform(2772)
        end
    end
	
    addEvent(function()
    local tile = Tile(leverwall.pos_wall)
    local stone = tile and tile:getItemById(leverwall.wall_id)
    if not stone then
    Game.createItem(leverwall.wall_id, 1, leverwall.pos_wall)
    leverwall.pos_wall:sendMagicEffect(CONST_ME_TELEPORT)
    Item(item.uid):transform(2772)
    end
end, 1 * 60 * 1000)

	exhaust[playerId] = currentTime + exhaustTime
    return true
end

for index, value in pairs(config) do
	lever:aid(index)
end

lever:register()

local topsecret = MoveEvent()

function topsecret.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	player:teleportTo(Position(32266, 31860, 12))
	return true
end

topsecret:type("stepin")
topsecret:aid(52037)
topsecret:register()