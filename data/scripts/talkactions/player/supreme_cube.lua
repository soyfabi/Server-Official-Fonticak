local config = {
    ["Cobra Bastion"] = {position = Position(32341, 32222, 7), text = "You have teleported to Cobra Bastion.", cooldown = 70, storage = 1252315},
    ["Falcon Bastion"] = {position = Position(32345, 32223, 7), text = "You have teleported to Falcon Bastion.", cooldown = 500, storage = 1252316},
}

local exhaust = {}
local supreme_cube = TalkAction("!supremecube", "!cube")

function supreme_cube.onSay(player, words, param)
    local playerId = player:getId()
    local currentTime = os.time()

    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
	if not player:getTile():hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You need to be in protection zone to use this command.")
		exhaust[playerId] = currentTime + 2
		return true
	end

    local destination = param:lower()
    local availableLocations = "[Open]:\n"
    local closedLocations = "[Closed]:\n"

    for location, boss in pairs(config) do
        local lastTeleport = player:getStorageValue(boss.storage)
        if lastTeleport ~= -1 and (currentTime - lastTeleport) < boss.cooldown then
            local remainingCooldown = boss.cooldown - (currentTime - lastTeleport)
            local minutes = math.floor(remainingCooldown / 60)
            local seconds = remainingCooldown % 60
			
            if minutes > 0 then
				closedLocations = closedLocations .. location .. " - Cooldown: " .. minutes .. "m " .. seconds .. "s.\n"
			else
				closedLocations = closedLocations .. location .. " - Cooldown: " .. seconds .. "s.\n"
			end
        else
            availableLocations = availableLocations .. location .. "\n"
        end
    end

    local allLocations = "[Supreme Cube]\nHere will be some of the locations of the bosses-\nit can be used to take you to places by just saying\nEX: !supremecube or !cube [Location].\n\nLocations open and closed:\n" .. availableLocations .. "\n" .. closedLocations

    if destination == "" then
        if player:getItemCount(31633) == 1 then
            player:popupFYI(allLocations)
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You need the [Supreme Cube] to use this command.")
        end
    else
        for location, boss in pairs(config) do
            if destination == location:lower() then
                local lastTeleport = player:getStorageValue(boss.storage)
                if lastTeleport == -1 or (currentTime - lastTeleport) >= boss.cooldown then
                    player:teleportTo(boss.position)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, boss.text)
                    player:setStorageValue(boss.storage, currentTime)
                    exhaust[playerId] = currentTime + 2
                    return true
                else
                    local remainingCooldown = boss.cooldown - (currentTime - lastTeleport)
                    local minutes = math.floor(remainingCooldown / 60)
                    local seconds = remainingCooldown % 60
                    player:sendCancelMessage("You must wait " .. minutes .. " minutes and " .. seconds .. " seconds before using this location again.")
                    exhaust[playerId] = currentTime + 2
                    return false
                end
            end
        end
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Location not found, say !supremecube to check locations.")
    end

    exhaust[playerId] = currentTime + 2
    return true
end

supreme_cube:separator(" ")
supreme_cube:register()













