local talkAction = TalkAction("!oldwall")

local exhaust = {}
local exhaustTime = 2

function talkAction.onSay(player, words, param, type)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return false
	end
	
	if param == "on" then
		player:setStorageValue(configManager.getNumber(configKeys.MAGIC_WALL_STORAGE), 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Old wall is now on.")
		exhaust[playerId] = currentTime + exhaustTime
		return false
	elseif param == "off" then
		player:setStorageValue(configManager.getNumber(configKeys.MAGIC_WALL_STORAGE), -1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Old wall is now off.")
		exhaust[playerId] = currentTime + exhaustTime
		return false
	end

	exhaust[playerId] = currentTime + exhaustTime
	player:sendCancelMessage("Usage: !oldwall on/off.")
	return false
end

talkAction:separator(" ")
talkAction:register()