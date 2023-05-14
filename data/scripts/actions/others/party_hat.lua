local partyHat = Action()

local exhaust = {}
local exhaustTime = 2

function partyHat.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	local slot = player:getSlotItem(CONST_SLOT_HEAD)
	if slot and item.uid == slot.uid then
		player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
		exhaust[playerId] = currentTime + exhaustTime
		return true
	end
	
	return false
end

partyHat:id(6578)
partyHat:register()
