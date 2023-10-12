

function onSpeak(player, type, message)
	player:sendChannelMessage("[BOT]", "It is not allowed to talk on this channel.", TALKTYPE_CHANNEL_R1, 3)
	return false
end

function onJoin(player)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "[Loot Channel]\nYou will now receive loot on this channel.")
	player:setStorageValue(Storage.STORAGEVALUE_LOOT, 1)
	return true
end

function onLeave(player)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "[Loot Channel]\nNow you will receive the loot in channel default.")
	player:setStorageValue(Storage.STORAGEVALUE_LOOT, -1)
	return false
end