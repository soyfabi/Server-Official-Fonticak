local fishTank = Action()

local exhaust = {}
local exhaustTime = 30

function fishTank.onUse(player, item, fromPosition, itemEx, toPosition)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	item:getPosition():sendMagicEffect(175)
	exhaust[playerId] = currentTime + exhaustTime
	return true
end

fishTank:id(23691)
fishTank:register()
