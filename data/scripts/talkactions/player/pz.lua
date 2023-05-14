local talk = TalkAction("!pz", "/pz", "!pk")

local exhaust = {}
local exhaustTime = 5

function talk.onSay(player, words, param, channel)

	local playerId = player:getId()
    local currentTime = os.time()
	if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("Wait (0." .. exhaust[playerId] - currentTime .. "s) for repeat again.")
        return false
	end

	if not player:isPzLocked() then
    player:sendTextMessage(MESSAGE_INFO_DESCR, 'You do not have PZ or PK.')
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	exhaust[playerId] = currentTime + exhaustTime
		return false
	end 
	
    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have to wait " .. (math.floor(player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT):getEndTime() / 1000) - os.time()) .. " second for PZ or PK.")
	exhaust[playerId] = currentTime + exhaustTime	
		return false
	end

talk:separator(" ")
talk:register()