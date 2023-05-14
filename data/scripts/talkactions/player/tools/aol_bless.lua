local Bless = TalkAction("!bless","!bles")
function Bless.onSay(player, words, param)
	local tile = Tile(player:getPosition())
	if not tile then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'Invalid tile position.')
		return false
	end

	local bless = 5
	local allBless = 0
	for i = 1, bless do
		if player:hasBlessing(i) then
			allBless = allBless + 1
		end
	end

	if allBless == bless then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You already have all blessings.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	if player:removeMoney(Settings.BlessValue) then
		for i = 1, bless do
			player:addBlessing(i)
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been blessed by the gods!")
		player:say("[BleSSed]")
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	else
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You don't have ".. Settings.BlessValue .." gold coins for buy bless. Cost: [300K = 3 CC].")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end

	return false
end

Bless:register()


local Aol = TalkAction("!aol", "!ao", "!aool")
local exhaust = {}
local exhaustTime = 2
function Aol.onSay(player, words, param)
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This Aol is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
	local tile = Tile(player:getPosition())
	if not tile then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'Invalid tile position.')
		return false
	end
	
	local itemType = ItemType(2173)
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
	
	if player:removeMoney(Settings.AolValue) then
		player:addItem(2173, 1)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		player:say("You bought an Aol.")
		exhaust[playerId] = currentTime + exhaustTime
	else
		player:sendCancelMessage("You dont have enought "..Settings.AolValue.." gold coins for buy an Aol. Cost: [100K = 1 CC].")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	
	return false
end

Aol:register()

