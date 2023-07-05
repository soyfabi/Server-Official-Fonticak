function onSpeak(player, type, message)
	player:sendChannelMessage("[BOT]", "It is not allowed to talk on this channel.", TALKTYPE_CHANNEL_R1, 5)
	return false
end

