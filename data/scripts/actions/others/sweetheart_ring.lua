local sweetheartRing = Action()

local exhaust = {}
local exhaustTime = 2

function sweetheartRing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	if item == player:getSlotItem(CONST_SLOT_RING) then
		player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
		exhaust[playerId] = currentTime + exhaustTime
		return true
	end
	return false
end

sweetheartRing:id(21955)
sweetheartRing:register()
