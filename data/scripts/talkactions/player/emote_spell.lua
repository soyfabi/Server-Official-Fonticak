-- Usage talkaction: "!emote on" or "!emote off"
local emoteSpell = TalkAction("!emotespells", "!emotespell", "!emote")

local exhaust = {}
local exhaustTime = 2

function emoteSpell.onSay(player, words, param, type)
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return false
	end
	
	if param == "on" then
		player:setStorageValue(90001, 1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You activated emoted spells.")
		exhaust[playerId] = currentTime + exhaustTime
		return false
	elseif param == "off" then
		player:setStorageValue(90001, 0)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You desactivated emoted spells.")
		exhaust[playerId] = currentTime + exhaustTime
		return false
	end
	player:sendCancelMessage("Usage: !emotespells on/off.")
	exhaust[playerId] = currentTime + exhaustTime
	return false
end

emoteSpell:separator(" ")
emoteSpell:register()