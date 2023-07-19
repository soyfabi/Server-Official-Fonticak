local maxPlayersPerMessage = 10
local playersOnline = TalkAction("!online")

local exhaust = {}
local exhaustTime = 2

function playersOnline.onSay(player, words, param)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This Commands is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
    local hasAccess = player:getGroup():getAccess()
    local players = Game.getPlayers()
    local onlineList = {}
    local vocationsCount = {
        Sorcerer = 0,
        Druid = 0,
        Paladin = 0,
        Knight = 0
    }

    for _, targetPlayer in ipairs(players) do
        if hasAccess or not targetPlayer:isInGhostMode() then
            table.insert(onlineList, ("%s [%d]"):format(targetPlayer:getName(), targetPlayer:getLevel()))

            local vocationName = targetPlayer:getVocation():getName()
            if vocationsCount[vocationName] then
                vocationsCount[vocationName] = vocationsCount[vocationName] + 1
            end

            -- Verificar promociones específicas y contabilizarlas en la vocación base
            if vocationName == "Master Sorcerer" then
                vocationsCount.Sorcerer = vocationsCount.Sorcerer + 1
            elseif vocationName == "Elder Druid" then
                vocationsCount.Druid = vocationsCount.Druid + 1
            elseif vocationName == "Royal Paladin" then
                vocationsCount.Paladin = vocationsCount.Paladin + 1
            elseif vocationName == "Elite Knight" then
                vocationsCount.Knight = vocationsCount.Knight + 1
            end
        end
    end

    local playersOnlineCount = #onlineList
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, ("%d players online."):format(playersOnlineCount))

    local vocationsSummary = "Vocations: "
    vocationsSummary = vocationsSummary .. "Sorcerer (" .. vocationsCount.Sorcerer .. " players), "
    vocationsSummary = vocationsSummary .. "Druid (" .. vocationsCount.Druid .. " players), "
    vocationsSummary = vocationsSummary .. "Paladin (" .. vocationsCount.Paladin .. " players), "
    vocationsSummary = vocationsSummary .. "Knight (" .. vocationsCount.Knight .. " players)."

    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, vocationsSummary)

    for i = 1, playersOnlineCount, maxPlayersPerMessage do
        local j = math.min(i + maxPlayersPerMessage - 1, playersOnlineCount)
        local msg = table.concat(onlineList, ", ", i, j) .. "."
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, msg)
    end
	
	exhaust[playerId] = currentTime + exhaustTime

    return false
end

playersOnline:register()