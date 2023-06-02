local deeperMineWagon = Action()

function deeperMineWagon.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.HiddenCityOfBeregar.RoyalRescue) == 2 then
		player:teleportTo(Position(32611, 31513, 9))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:setDirection(DIRECTION_EAST)
	elseif player:getStorageValue(Storage.HiddenCityOfBeregar.RoyalRescue) >= 3 then
		player:teleportTo(Position(32687, 31471, 13))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:setDirection(DIRECTION_NORTH)
	else
		player:teleportTo(Position(32566, 31505, 9))
		player:setDirection(DIRECTION_SOUTH)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	
	if item.actionid == 50129 then
		if player:getStorageValue(Storage.HiddenCityOfBeregar.TunnelSecret) == 1 then
			player:teleportTo(Position(32588, 31478, 14))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:setDirection(DIRECTION_EAST)
		end
	end
	
	return true
end

deeperMineWagon:aid(50128, 50129)
deeperMineWagon:register()

local oreWagon = Action()

local config = {
	[50098] = Position(32687, 31470, 13),
	[50099] = Position(32600, 31504, 13),
	[50100] = Position(32604, 31338, 11),
	[50101] = Position(32611, 31513, 9),
	[50102] = Position(32652, 31507, 10),
	[50103] = Position(32692, 31501, 11),
	[50104] = Position(32687, 31470, 13),
	[50105] = Position(32687, 31470, 13),
	[50106] = Position(32687, 31470, 13),
	[50107] = Position(32580, 31487, 9),
	[50108] = Position(32687, 31470, 13)
}

function oreWagon.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetPosition = config[item.actionid]
	if not targetPosition then
		return true
	end

	if player:getStorageValue(Storage.HiddenCityOfBeregar.OreWagon) == 1 then
		player:teleportTo(targetPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't know how to use this yet.")
	return true
end

oreWagon:aid(50098, 50099, 50100, 50101, 50102, 50103, 50104, 50105, 50106, 50107, 50108)
oreWagon:register()

local gapWagon = Action()

function Position:createItem(itemid, count)
    local toTile = Tile(self)
    if not toTile or not toTile:getItems() or not toTile:getGround() then
        doAreaCombatHealth(0, 0, self, 0, 0, 0, CONST_ME_NONE)
        Game.createItem(itemid, count, self):setActionId(50109)
    end
end

function Position:createItem2(itemid, count)
    local toTile = Tile(self)
    if toTile or toTile:getItems() or toTile:getGround() then
        doAreaCombatHealth(0, 0, self, 0, 0, 0, CONST_ME_NONE)
        Game.createItem(itemid, count, self):setActionId(50109)
    end
end

function gapWagon.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = Tile(Position(32571, 31508, 9))
	if tile and tile:getItemById(7122) and player:getStorageValue(Storage.HiddenCityOfBeregar.RoyalRescue) == 1 then
		player:setStorageValue(Storage.HiddenCityOfBeregar.RoyalRescue, 2)
		player:teleportTo(Position(32578, 31507, 9))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("You safely passed the gap but your bridge collapsed behind you.", TALKTYPE_MONSTER_SAY, false, 0, player:getPosition())
		tile:getItemById(5770):remove()
		tile:getItemById(7122):remove()
		local position2 = Position(32571, 31508, 9)
		position2:createItem(4600, 1)
		position2:createItem2(291, 1)
		position2:createItem2(295, 1)	
	else
		player:teleportTo(Position(32580, 31487, 9))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("You need to build a bridge to pass the gap.", TALKTYPE_MONSTER_SAY, false, 0, player:getPosition())
	end
	return true
end

gapWagon:aid(50112)
gapWagon:register()

local gapWagon2 = Action()

function gapWagon2.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = Tile(Position(32619, 31514, 9))
	local tilec = Tile(Position(32617, 31513, 9))
	local tilec2 = Tile(Position(32617, 31514, 9))
	if not tile:getItemById(5709) then
		player:teleportTo(Position(32625, 31514, 9))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:setDirection(DIRECTION_EAST)
		player:say("It has closed again, I was very lucky.", TALKTYPE_MONSTER_SAY, false, 0, player:getPosition())
		local position = Position(32619, 31514, 9)
		Game.createItem(5709, 1, position):setActionId(50114)
		player:say("Puuuh!", TALKTYPE_MONSTER_SAY, false, 0, position)
		position:sendMagicEffect(CONST_ME_POFF)
		tilec:getItemById(1272):remove()
		tilec2:getItemById(1624):remove()
	else
		player:teleportTo(Position(32579, 31487, 9))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:setDirection(DIRECTION_EAST)
		player:say("You need to build a column and remove the rock, to go with the wagon.", TALKTYPE_MONSTER_SAY, false, 0, player:getPosition())
	end
	return true
end

gapWagon2:aid(50113)
gapWagon2:register()

local gapWagon3 = Action()

function gapWagon3.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:say("The wagon cannot pass, you will have to go the other way.", TALKTYPE_MONSTER_SAY, false, 0, player:getPosition())
	return true
end

gapWagon3:aid(50114)
gapWagon3:register()

local coalWagon = Action()

local wagons = {
	[7131] = Position(32717, 31492, 11),
	[9118] = Position(32699, 31492, 11)
}

function coalWagon.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lastPosition = wagons[item.itemid]
	if not lastPosition then
		return false
	end

	local wagonPosition = item:getPosition()
	if wagonPosition == lastPosition then
		return false
	end

	local tile = Tile(wagonPosition)
	if item.itemid == 7131 and item.actionid == 50117 then
		wagonPosition.x = wagonPosition.x + 1
		tile:getItemById(7131):moveTo(wagonPosition)
	elseif item.itemid == 9118 and item.actionid == 50117 then
		wagonPosition.x = wagonPosition.x - 1
		tile:getItemById(9118):moveTo(wagonPosition)
	end

	player:say("SQUEEEEAK", TALKTYPE_MONSTER_SAY, false, 0, wagonPosition)
	return true
end

coalWagon:aid(50117)
coalWagon:register()

local coalLevers = Action()

local config = {
	[50108] = {actionId = 50122, wagonPos = Position(32696, 31495, 11)},
	[50109] = {actionId = 50123, wagonPos = Position(32694, 31495, 11)},
	[50110] = {actionId = 50124, wagonPos = Position(32692, 31495, 11)},
	[50111] = {actionId = 50125, wagonPos = Position(32690, 31495, 11)}
}

function coalLevers.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local useItem = config[item.uid]
	if not useItem then
		return true
	end

	local machine = Tile(Position(32699, 31494, 11)):getItemById(7813)
	if not machine then
		return false
	end
	
	local bellow = Tile(Position(32699, 31495, 11)):getItemById(9121)
	if not bellow then
		return false
	end
	
	if Tile(Position(32690, 31495, 11)):getItemById(7132) or Tile(Position(32692, 31495, 11)):getItemById(7132) or Tile(Position(32694, 31495, 11)):getItemById(7132) or Tile(Position(32696, 31495, 11)):getItemById(7132) then
		player:say("There is already a wagon in use.", TALKTYPE_MONSTER_SAY, false, 0, player:getPosition())
		return true
	end
	
	if machine.actionid == 50120 and machine.itemid == 7813 then
	if bellow.actionid == 50132 and bellow.itemid == 9121 then
		local wagon = Game.createItem(7132, 1, useItem.wagonPos)
		Tile(Position(32699, 31495, 11)):getItemById(9121):remove()
		Game.createItem(9121, 1, Position(32699, 31495, 11)):setActionId(50110)
		Game.createItem(7814, 1, Position(32699, 31494, 11))
		machine:remove(1)
		if wagon then
		wagon:setActionId(useItem.actionId)
		end
	end
end

	item:transform(item.itemid == 9125 and 9126 or 9125)
	return true
end

coalLevers:uid(50108, 50109, 50110, 50111)
coalLevers:register()

local bellow = MoveEvent()

local exhaust = {}
local exhaustTime = 2

function bellow.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end
	
	local playerId = creature:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		return true
	end
	
	local crucibleItem = Tile(Position(32699, 31495, 11)):getItemById(9120)
	if not crucibleItem then
		return true
	end
	
	
	if crucibleItem.actionid == 50110 then
		crucibleItem:setActionId(50120)
		Position(32697, 31494, 11):sendMagicEffect(CONST_ME_SMOKE)
		Position(32695, 31494, 10):sendMagicEffect(CONST_ME_SMOKE)
		Position(32696, 31494, 10):sendMagicEffect(CONST_ME_SMOKE)
	elseif crucibleItem.actionid == 50120 then
		crucibleItem:setActionId(50121)
		Position(32697, 31494, 11):sendMagicEffect(CONST_ME_SMOKE)
		Position(32695, 31494, 10):sendMagicEffect(CONST_ME_SMOKE)
		Position(32696, 31494, 10):sendMagicEffect(CONST_ME_SMOKE)
		creature:say('TSSSSHHHHH', TALKTYPE_MONSTER_SAY, false, 0, Position(32695, 31494, 11))
		creature:say('CHOOOOOOOHHHHH', TALKTYPE_MONSTER_SAY, false, 0, Position(32698, 31493, 11))
	elseif crucibleItem.actionid == 50121 then
		crucibleItem:setActionId(50130)
		Position(32697, 31494, 11):sendMagicEffect(CONST_ME_SMOKE)
		Position(32695, 31494, 10):sendMagicEffect(CONST_ME_SMOKE)
		Position(32696, 31494, 10):sendMagicEffect(CONST_ME_SMOKE)
		creature:say('TSSSSHHHHH', TALKTYPE_MONSTER_SAY, false, 0, Position(32695, 31494, 11))
		creature:say('CHOOOOOOOHHHHH', TALKTYPE_MONSTER_SAY, false, 0, Position(32698, 31493, 11))
	elseif crucibleItem.actionid == 50130 then
		crucibleItem:setActionId(50131)
		Position(32697, 31494, 11):sendMagicEffect(CONST_ME_SMOKE)
		Position(32695, 31494, 10):sendMagicEffect(CONST_ME_SMOKE)
		Position(32696, 31494, 10):sendMagicEffect(CONST_ME_SMOKE)
		creature:say('TSSSSHHHHH', TALKTYPE_MONSTER_SAY, false, 0, Position(32695, 31494, 11))
		creature:say('CHOOOOOOOHHHHH', TALKTYPE_MONSTER_SAY, false, 0, Position(32698, 31493, 11))
	elseif crucibleItem.actionid == 50131 then
		crucibleItem:setActionId(50132)
		creature:say('TSSSSHHHHH', TALKTYPE_MONSTER_SAY, false, 0, Position(32695, 31494, 11))
		creature:say('CHOOOOOOOHHHHH', TALKTYPE_MONSTER_SAY, false, 0, Position(32698, 31493, 11))
	elseif crucibleItem.actionid == 50132 then
		crucibleItem:transform(9121)
		creature:say('TSSSSHHHHH', TALKTYPE_MONSTER_SAY, false, 0, Position(32695, 31494, 11))
		creature:say('CHOOOOOOOHHHHH', TALKTYPE_MONSTER_SAY, false, 0, Position(32698, 31493, 11))
	end
	
	exhaust[playerId] = currentTime + exhaustTime
	
	return true
end

bellow:type("stepin")
bellow:aid(50110, 50120, 50121, 50130, 50131, 50132)
bellow:register()

local coalExitWagons = Action()

local config = {
	[50122] = Position(32704, 31507, 12), -- small tunnel with golems
	[50123] = Position(32661, 31495, 13), -- mushroom quest
	[50124] = Position(32687, 31470, 13), -- wagon maze
	[50125] = Position(32690, 31495, 11) -- room with lava that I couldn't find, setting destination to the same as mushroom quest
}

function coalExitWagons.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetPosition = config[item.actionid]
	if not targetPosition then
		return true
	end

	player:teleportTo(targetPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	item:remove()
	return true
end

coalExitWagons:aid(50122, 50123, 50124, 50125)
coalExitWagons:register()

local wagonMazeLevers = Action()

local levers = {
	[50113] = Position(32696, 31453, 13),
	[50114] = Position(32692, 31453, 13),
	[50115] = Position(32687, 31452, 13),
	[50116] = Position(32682, 31455, 13),
	[50117] = Position(32688, 31456, 13),
	[50118] = Position(32692, 31459, 13),
	[50119] = Position(32696, 31461, 13),
	[50120] = Position(32695, 31464, 13),
	[50121] = Position(32690, 31465, 13),
	[50122] = Position(32684, 31464, 13),
	[50123] = Position(32688, 31469, 13)
}

function wagonMazeLevers.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lever = levers[item.uid]
	if lever then
		local tile = Tile(lever)
		if tile:getItemById(7130) then
			tile:getItemById(7130):transform(7121)
		else
			local targetItem = tile:getItems()[1]
			targetItem:transform(targetItem:getId() + 1)
		end
	end

	item:transform(item.itemid == 8913 and 8914 or 8913)
	return true
end

wagonMazeLevers:uid(50113, 50114, 50115, 50116, 50117, 50118, 50119, 50120, 50121, 50122, 50123)
wagonMazeLevers:register()

local wagonMazeExit = Action()

function wagonMazeExit.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local destinations = {
		{teleportPos = Position(32692, 31501, 11), railCheck = Tile(Position(32688, 31469, 13)):getItemById(7124) and Tile(Position(32690, 31465, 13)):getItemById(7122)}, -- Coal Room
		{teleportPos = Position(32549, 31407, 11), railCheck = Tile(Position(32688, 31469, 13)):getItemById(7124) and Tile(Position(32690, 31465, 13)):getItemById(7125) and Tile(Position(32684, 31464, 13)):getItemById(7123)}, -- Infested Tavern
		{teleportPos = Position(32639, 31958, 10), railCheck = Tile(Position(32688, 31469, 13)):getItemById(7124) and Tile(Position(32690, 31465, 13)):getItemById(7125) and Tile(Position(32684, 31464, 13)):getItemById(7122) and Tile(Position(32682, 31455, 13)):getItemById(7124)}, -- Beregar
		{teleportPos = Position(32702, 31450, 15), railCheck = Tile(Position(32688, 31469, 13)):getItemById(7124) and Tile(Position(32690, 31465, 13)):getItemById(7125) and Tile(Position(32684, 31464, 13)):getItemById(7122) and Tile(Position(32682, 31455, 13)):getItemById(7121) and Tile(Position(32687, 31452, 13)):getItemById(7125) and Tile(Position(32692, 31453, 13)):getItemById(7126)}, -- NPC Tehlim
		{teleportPos = Position(32721, 31487, 15), railCheck = Tile(Position(32688, 31469, 13)):getItemById(7121) and Tile(Position(32692, 31459, 13)):getItemById(7123) and Tile(Position(32696, 31453, 13)):getItemById(7123)}, -- Troll tribe's hideout
		{teleportPos = Position(32600, 31504, 13), railCheck = Tile(Position(32688, 31469, 13)):getItemById(7123) and Tile(Position(32695, 31464, 13)):getItemById(7123)} -- City's Entrance
	}

	for i = 1, #destinations do
		local destination = destinations[i]
		if destination.railCheck then
			player:teleportTo(destination.teleportPos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end
	return true
end

wagonMazeExit:uid(50124)
wagonMazeExit:register()

local ladder = Action()

function ladder.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:teleportTo(Position(32680, 31508, 10))
	return true
end

ladder:aid(10035)
ladder:register()

local oreWagon = MoveEvent()

function oreWagon.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.HiddenCityOfBeregar.OreWagon) ~= 1 then
		player:setStorageValue(Storage.HiddenCityOfBeregar.OreWagon, 1)
		player:say ('You have found the entrance to the hidden city of Beregar and may now use the ore wagon.')
	end
	
	return true
end

oreWagon:type("stepin")
oreWagon:aid(50091)
oreWagon:register()

local elevator = MoveEvent()

local config = {
	[50092] = Position(32612, 31499, 15),
	[50093] = Position(32612, 31499, 14)
	
	
}

function elevator.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = config[item.actionid]
	if not teleport then
		return true
	end

	if player:getStorageValue(Storage.HiddenCityOfBeregar.GoingDown) == 2 then
		player:teleportTo(teleport, true)
		player:setDirection(DIRECTION_SOUTH)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You don\'t know how to use this yet.')
	end
	return true
end

elevator:type("stepin")
elevator:aid(50092, 50093)
elevator:register()

local tunel = MoveEvent()

function tunel.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(Position(32616, 31514, 9))
	player:say('Use the ore wagon to pass this spot.', TALKTYPE_MONSTER_SAY)
	return true
end

tunel:type("stepin")
tunel:aid(50116)
tunel:register()

local bridgeTeleport = MoveEvent()

function bridgeTeleport.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	creature:teleportTo(Position(32637, 31509, 10))
	creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

bridgeTeleport:type("stepin")
bridgeTeleport:aid(50199)
bridgeTeleport:register()


local tunnelsecret = MoveEvent()

function tunnelsecret.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	if player:getStorageValue(Storage.HiddenCityOfBeregar.TunnelSecret) ~= 1 then
		player:say('Huh?! It seems you have found a secret passage!', TALKTYPE_MONSTER_SAY)
		player:setStorageValue(Storage.HiddenCityOfBeregar.TunnelSecret, 1)
		player:addAchievement("Unlikely Pathfinder")
	end
	
	return true
end

tunnelsecret:type("stepin")
tunnelsecret:aid(50118)
tunnelsecret:register()
