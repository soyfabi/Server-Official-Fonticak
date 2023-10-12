local pos = {
	[2025] = {x = 32831, y = 32333, z = 11},
	[2026] = {x = 32833, y = 32333, z = 11},
	[2027] = {x = 32835, y = 32333, z = 11},
	[2028] = {x = 32837, y = 32333, z = 11}
}


local function revertLever(position)
	local leverItem = Tile(position):getItemById(2773)
	if leverItem then
		leverItem:transform(2772)
	end
end

local function doRemoveFirewalls(fwPos)
	local tile = Position(fwPos):getTile()
	if tile then
		local thing = tile:getItemById(6288)
		if thing then
			thing:remove()
		end
	end
end

local exhaust = {}
local exhaustTime = 1

local pitsOfInfernoWalls = Action()
function pitsOfInfernoWalls.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end

	if(item.itemid == 2772) then
		doRemoveFirewalls(pos[item.uid])
		Position(pos[item.uid]):sendMagicEffect(CONST_ME_FIREAREA)
		addEvent(revertLever, 10 * 60 * 1000, toPosition)
	else
		Game.createItem(6288, 1, pos[item.uid])
		Position(pos[item.uid]):sendMagicEffect(CONST_ME_FIREAREA)
	end
	
	local teleportDestinations = {
		[Position(32831, 32333, 11)] = Position(32830, 32333, 11),
		[Position(32833, 32333, 11)] = Position(32832, 32333, 11),
		[Position(32835, 32333, 11)] = Position(32834, 32333, 11),
		[Position(32837, 32333, 11)] = Position(32836, 32333, 11)
	}
	
	function teleportPlayersToDestinations(teleportDestinations)
		for targetPos, teleportTargetPos in pairs(teleportDestinations) do
			local tile = targetPos:getTile()
			if tile then
				local players = tile:getCreatures()
				for _, player in ipairs(players) do
					if player:isPlayer() then
						player:teleportTo(teleportTargetPos, true)
					end
				end
			end
		end
	end
	
	local function createFirewallIfNeeded(position)
		local tile = position:getTile()
		if tile then
			local thing = tile:getItemById(6288)
			if not thing then
				Game.createItem(6288, 1, position)
				teleportPlayersToDestinations(teleportDestinations)
			end
		end
	end
	addEvent(function() createFirewallIfNeeded(Position(pos[item.uid])) end, 10 * 60 * 1000)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have 10 minute to pass, or the flames will close again.")
	exhaust[playerId] = currentTime + exhaustTime
	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

for unique, info in pairs(pos) do
	pitsOfInfernoWalls:uid(unique)
end

pitsOfInfernoWalls:register()
