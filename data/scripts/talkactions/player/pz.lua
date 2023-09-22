local talk = TalkAction("!pz", "/pz", "!pk")

local exhaust = {}
local exhaustTime = 1

function talk.onSay(player, words, param, channel)

	local playerId = player:getId()
    local currentTime = os.time()
	if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("Wait (0." .. exhaust[playerId] - currentTime .. "s) for repeat the command again.")
        return false
	end

	if not player:isPzLocked() then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'You do not have battle.')
		exhaust[playerId] = currentTime + exhaustTime
		return false
	end
	
	local remainingTime = math.floor(player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT):getEndTime() / 1000) - os.time()
	
	if remainingTime < 60 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have to wait " .. remainingTime .. " second" .. (remainingTime > 1 and "s" or "") .. " for PZ.")
	else
		local minutes = math.floor(remainingTime / 60)
		local seconds = remainingTime % 60
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have to wait " .. minutes .. " minute" .. (minutes > 1 and "s" or "") .. " and " .. seconds .. " second" .. (seconds > 1 and "s" or "") .. " for PZ.")
	end
	
	exhaust[playerId] = currentTime + exhaustTime	
	return false
end

talk:register()