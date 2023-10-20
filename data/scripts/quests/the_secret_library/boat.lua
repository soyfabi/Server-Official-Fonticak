local boats = {
	{pos = {x = 33344, y = 31349, z = 7}, destination = Position(33326, 31351, 7), unlockShortcut = Storage.TheSecretLibrary.ShortcutToBastion},
	{pos = {x = 33373, y = 31309, z = 7}, destination = Position(33382, 31292, 7)},
	{pos = {x = 33382, y = 31294, z = 7}, destination = Position(33374, 31310, 7)},
	{pos = {x = 33328, y = 31352, z = 7}, destination = Position(33346, 31348, 7), access = Storage.TheSecretLibrary.ShortcutToBastion}
}

local boat = Action()

local exhaust = {}
local exhaustTime = 2

function boat.onUse(player, item, fromPosition, itemEx, toPosition)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	for b = 1, #boats do
		if item:getPosition() == Position(boats[b].pos) then
			if boats[b].unlockShortcut then
				if player:getStorageValue(boats[b].unlockShortcut) < 1 then
					player:setStorageValue(boats[b].unlockShortcut, 1)
				end
			end
			if boats[b].access then
				if player:getStorageValue(boats[b].access) == 1 then
					player:teleportTo(boats[b].destination)
					player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
					exhaust[playerId] = currentTime + exhaustTime
					return true
				end
			else
				player:teleportTo(boats[b].destination)
				player:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
				exhaust[playerId] = currentTime + exhaustTime
				return true
			end
		end
	end
end

boat:aid(46345)
boat:register()
