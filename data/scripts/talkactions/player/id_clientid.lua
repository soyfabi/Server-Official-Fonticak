local talk = TalkAction("!id", "!clientid", "!client")

local exhaust = {}
local exhaustTime = 2

function talk.onSay(player, words, param)
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return false
	end

    local split = param:split(",")

    local itemType = nil
    local data = tonumber(split[1]) or split[1]
    if(type(data) == "number") then
        for id = 100, 99999 do
            local clientType = ItemType(id)
            if(clientType:getClientId() == data) then
                itemType = clientType
            end
        end
    else
        itemType = ItemType(data)
    end

    if(itemType == nil or itemType:getId() == 0) then
        player:sendCancelMessage("There is no item with that id or name. Example: !id hailstorm rod.")
        return false
    end

    
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "".. itemType:getName()..", Client ID is: [".. itemType:getClientId() .."].")
	player:sendTextMessage(MESSAGE_INFO_DESCR, "".. itemType:getName()..", Client ID is: [".. itemType:getClientId() .."].")
	exhaust[playerId] = currentTime + exhaustTime
    return false
end

talk:separator(" ")
talk:register()
