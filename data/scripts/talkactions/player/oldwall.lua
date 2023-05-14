local talkAction = TalkAction("!oldwall")

function talkAction.onSay(player, words, param, type)
	if param == "on" then
		player:setStorageValue(configManager.getNumber(configKeys.MAGIC_WALL_STORAGE), 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Old wall is now on.")
		return false
	elseif param == "off" then
		player:setStorageValue(configManager.getNumber(configKeys.MAGIC_WALL_STORAGE), -1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Old wall is now off.")
		return false
	end

	player:sendCancelMessage("Usage: !oldwall on/off")
	return false
end

talkAction:separator(" ")
talkAction:register()