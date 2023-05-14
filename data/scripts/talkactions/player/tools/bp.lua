local bp_random = {
   { item = 1988 }, -- backpack
   { item = 1998 }, -- green backpack
   { item = 1999 }, -- yellow backpack
   { item = 2000 }, -- red backpack
   { item = 2001 }, -- purple backpack
   { item = 2002 }, -- blue backpack
   { item = 2003 }, -- grey backpack
   { item = 2004 }, -- golden backpack
   { item = 10519 }, -- orange backpack
  
}

local exhaust = {}
local exhaustTime = 30

local bp = TalkAction("!bp","!backpack")
local price_bp = 10000

function bp.onSay(player, words, param)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("The Backpack is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end

	local tile = Tile(player:getPosition())
	if not tile then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'Invalid tile position.')
		return false
	end

	local itemType = ItemType(1988)
	local itemWeight = itemType:getWeight()
	local playerCap = player:getFreeCapacity()
	if playerCap < itemWeight then
		itemWeight = itemWeight / 100
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You have found a " .. itemType:getName() .. " weighing " .. itemWeight .. " oz it's too heavy.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)			
	if not backpack or backpack:getEmptySlots(false) < 1 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Your main backpack is full. You need to free up 1 available slots to get " .. itemType:getName() .. ".")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

    if player:removeMoney(price_bp) then
        player:getPosition():sendMagicEffect(15)
		local random = math.random(1, #bp_random)
         player:addItem(bp_random[random].item, bp_random)
		player:sendCancelMessage("You bought an ".. getItemNameById(bp_random[random].item) .. ".")
		player:say("You bought an ".. getItemNameById(bp_random[random].item) .. ".")
		exhaust[playerId] = currentTime + exhaustTime
    else
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendCancelMessage("You don't have ".. price_bp .."GP of money.")	
    end
	
    return false
end

bp:register()