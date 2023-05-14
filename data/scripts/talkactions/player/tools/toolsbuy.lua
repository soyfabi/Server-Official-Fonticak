local Machete = TalkAction("!machete", "!machet")
local exhaust = {}
local exhaustTime = 30
function Machete.onSay(player, words, param)
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("The Machete is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
	local tile = Tile(player:getPosition())
	if not tile then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'Invalid tile position.')
		return false
	end
	
	local itemType = ItemType(2420)
	local itemWeight = itemType:getWeight()
	local playerCap = player:getFreeCapacity()
	if playerCap < itemWeight then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You have found a " .. itemType:getName() .. " weighing " .. (itemWeight / 100) .. " oz it's too heavy.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)			
	if not backpack or backpack:getEmptySlots(false) < 1 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Your main backpack is full. You need to free up 1 available slots to get " .. itemType:getName() .. ".")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	
	if player:removeMoney(Settings.MacheteValue) then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		player:say("You bought an Machete.")
		player:addItem(2420, 1)	
		exhaust[playerId] = currentTime + exhaustTime
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("You dont have "..Settings.MacheteValue.." Golds.")
	end
	return false
end

Machete:register()

local Pick = TalkAction("!pick", "!pickaxe", "!pico")
local exhaust = {}
local exhaustTime = 30
function Pick.onSay(player, words, param)
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("The Pick is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
	local tile = Tile(player:getPosition())
	if not tile then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'Invalid tile position.')
		return false
	end
	
	local itemType = ItemType(2553)
	local itemWeight = itemType:getWeight()
	local playerCap = player:getFreeCapacity()
	if playerCap < itemWeight then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You have found a " .. itemType:getName() .. " weighing " .. (itemWeight / 100) .. " oz it's too heavy.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)			
	if not backpack or backpack:getEmptySlots(false) < 1 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Your main backpack is full. You need to free up 1 available slots to get " .. itemType:getName() .. ".")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	
	if player:removeMoney(Settings.PickAxeValue) then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		player:say("You bought an Pick Axe.")
		player:addItem(2553, 1)	
		exhaust[playerId] = currentTime + exhaustTime
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("You dont have "..Settings.PickAxeValue.." Golds.")
	end
	return false
end

Pick:register()

local Shovel = TalkAction("!shovel", "!pala")
local exhaust = {}
local exhaustTime = 30
function Shovel.onSay(player, words, param)
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("The Shovel is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
	local tile = Tile(player:getPosition())
	if not tile then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'Invalid tile position.')
		return false
	end
	
	local itemType = ItemType(2554)
	local itemWeight = itemType:getWeight()
	local playerCap = player:getFreeCapacity()
	if playerCap < itemWeight then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You have found a " .. itemType:getName() .. " weighing " .. (itemWeight / 100) .. " oz it's too heavy.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)			
	if not backpack or backpack:getEmptySlots(false) < 1 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Your main backpack is full. You need to free up 1 available slots to get " .. itemType:getName() .. ".")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	
	if player:removeMoney(Settings.ShovelValue) then
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		player:say("You bought an Shovel.")
		player:addItem(2554, 1)	
		exhaust[playerId] = currentTime + exhaustTime
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("You dont have "..Settings.ShovelValue.." Golds.")
	end
	return false
end

Shovel:register()