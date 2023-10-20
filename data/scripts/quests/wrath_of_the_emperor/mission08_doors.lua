local doors = Action()

local exhaust = {}
local exhaustTime = 2

function doors.onUse(player, target)
	if not player then
		return true
	end
	
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	local pos = player:getPosition()
	local tpos = target:getPosition()
	if pos.y == 31112 then
		player:teleportTo(Position(tpos.x, tpos.y-1, 12))
		pos:sendMagicEffect(CONST_ME_POFF)
	else
		player:teleportTo(Position(tpos.x, tpos.y+1, 12))
		pos:sendMagicEffect(CONST_ME_POFF)
	end
	exhaust[playerId] = currentTime + exhaustTime
	return true
end

doors:id(11141)
doors:register()
