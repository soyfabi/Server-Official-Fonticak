

function onSpeak(player, type, message)
	player:sendChannelMessage("[BOT]", "It is not allowed to talk on this channel.", TALKTYPE_CHANNEL_R1, 3)
	return false
end

function onJoin(player)
	player:setStorageValue(809013, 1)
	addEvent(function(cid)
        local player = Player(cid)
        if not player then return end
        player:sendChannelMessage("[BOT]", "In this channel you can see the status of the task active.", TALKTYPE_CHANNEL_O, 3)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "[Task Channel]\nNow you will receive the status of the task in this channel.")
    end, 100, player.uid)
	return true
end

function onLeave(player)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "[Task Channel]\nNow you will receive the status of the task in channel default.")
	player:setStorageValue(809013, -1)
	return false
end