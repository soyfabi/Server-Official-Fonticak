local guildinfo = Action()

local guildinfo = TalkAction("!guildinfo","!guild", "/guildinfo", "/guild")
local exhaust = {}
local exhaustTime = 1
function guildinfo.onSay(player, words, param)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This Commands is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
	

	local guild = player:getGuild()
	if not guild then
        player:sendCancelMessage("You are not in a guild.")
        return false
    end
	
	local membersOnline = guild:getMembersOnline()
    local membersOnlineCount = 0
    local memberInfo = {}
    local maxMembersToShow = 3

    for _, member in pairs(membersOnline) do
        if membersOnlineCount >= maxMembersToShow then
            break
        end

        local playerName = Player(member):getName()
        local playerLevel = Player(member):getLevel()
        local memberData = playerName .. " (Level " .. playerLevel .. ")."
        table.insert(memberInfo, memberData)
        membersOnlineCount = membersOnlineCount + 1
    end

    local memberInfoStr = table.concat(memberInfo, "\n")
	
	local text = "[Guild Info]\nAll your guild information.\n\n"
	text = text .. "Your guild is: [".. guild:getName() .."].\n\n"
	text = text .. "Members online: " .. membersOnlineCount .. ":\n" .. memberInfoStr .. "\n"

	
	exhaust[playerId] = currentTime + exhaustTime
	player:popupFYI(text)
	return false
end

guildinfo:register()