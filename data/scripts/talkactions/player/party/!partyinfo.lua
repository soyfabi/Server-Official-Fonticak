local partyinfo = TalkAction("!partyinfo","!party", "/partyinfo", "/party")
local exhaust = {}
local exhaustTime = 2
function partyinfo.onSay(player, words, param)
    local exhaustTime = 10 -- Tiempo de enfriamiento en segundos
    local exhaust = {} -- Tabla para almacenar los tiempos de enfriamiento por jugador

    local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This command is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
	function getAbbreviatedVocationName(fullName)
    local vocationMap = {
        ["Sorcerer"] = "Sorcerer",
		["Master Sorcerer"] = "MS",
        ["Druid"] = "Druid",
		["Elder Druid"] = "ED",
        ["Paladin"] = "Paladin",
		["Royal Paladin"] = "RP",
        ["Knight"] = "Knight",
		["Elite Knight"] = "EK"
    }
		return vocationMap[fullName] or fullName
	end

    local text = "[Party Information]\nHere is the information of your party:\n"
    local party = player:getParty()
    if party then
        local members = party:getMembers()
        local memberCount = #members

        -- Sort members by level (descending order)
        table.sort(members, function(a, b)
            return a:getLevel() > b:getLevel()
        end)

        local count = 0
        local leader = party:getLeader()
		text = text .. "\n[Leader]\n"
        if leader then
            local distance = math.floor(player:getPosition():getDistance(leader:getPosition()))
			local vocationName = getAbbreviatedVocationName(leader:getVocation():getName())
            text = text .. "Leader: " .. leader:getName() .. " (Level: " .. leader:getLevel() .. ", Voc: " .. vocationName ..", Distance: " .. distance .. "sqm).\n\n"
            totalLevels = leader:getLevel()
        end
        text = text .. "Total Party Members: " .. memberCount .. " ->\n"
        -- Add party member information to the text
        local totalLevels = totalLevels or 0
        local topMemberName = ""
        local topMemberLevel = 0
        for _, member in ipairs(members) do
            count = count + 1
            if count <= 10 then
                local distance = math.floor(player:getPosition():getDistance(member:getPosition()))
                local vocationName = getAbbreviatedVocationName(member:getVocation():getName())
                text = text .. "Member: " .. member:getName() .. " (Level: " .. member:getLevel() .. ", Voc: " .. vocationName .. ", Distance: " .. distance .. "sqm).\n"
                totalLevels = totalLevels + member:getLevel()

                if member:getLevel() > topMemberLevel then
                    topMemberName = member:getName()
                    topMemberLevel = member:getLevel()
                end
            else
                break
            end
        end

        text = text .. "\n[Information Additional]"

        if topMemberName ~= "" then
            text = text .. "\nTop Member: " .. topMemberName .. " -> Level " .. topMemberLevel .. "."
        end
        text = text .. "\nTotal Levels: " .. totalLevels .. "."

        if party:isSharedExperienceEnabled() then
            text = text .. "\nShared Experience is active!"
        else
            text = text .. "\nShared Experience is not active."
        end

    else
        text = text .. "You are not in a party."
    end

    exhaust[playerId] = currentTime + exhaustTime
    player:popupFYI(text)
    return false
end

partyinfo:register()

local partykick = TalkAction("!partykick")
function partykick.onSay(player, words, param)
    local exhaustTime = 10 -- Tiempo de enfriamiento en segundos
    local exhaust = {} -- Tabla para almacenar los tiempos de enfriamiento por jugador
    local maxDistance = 30 -- Distancia máxima en sqm para poder expulsar a un miembro

    local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This command is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end

    if not param or param == "" then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Usage: !partykick <playername>")
        return false
    end

    local party = player:getParty()
    if party then
        local leader = party:getLeader()
        if leader and leader:getName() == player:getName() then
            local memberToKick = nil
            local members = party:getMembers()
            for _, member in ipairs(members) do
                if member:getName():lower() == param:lower() then
                    memberToKick = member
                    break
                end
            end
            if memberToKick then
                local distance = math.floor(player:getPosition():getDistance(memberToKick:getPosition()))
                if distance <= maxDistance then
                    if memberToKick:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "Cannot kick [" .. memberToKick:getName() .. "] from the party. They are in combat.")
                    else
                        party:removeMember(memberToKick)
                        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have kicked [" .. memberToKick:getName() .. "] from the party.")
                    end
                else
                    player:sendTextMessage(MESSAGE_INFO_DESCR, "You have kicked [" .. memberToKick:getName() .. "] from the party.")
					party:removeMember(memberToKick)
                end
            else
                player:sendTextMessage(MESSAGE_INFO_DESCR, "Player [" .. param .. "] is not in your party.")
            end
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Only the party leader can kick members.")
        end
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not in a party.")
    end

    exhaust[playerId] = currentTime + exhaustTime
    return false
end

partykick:separator(" ")
partykick:register()





local partyinvite = TalkAction("!partyinvite")

local invitations = {} -- Tabla para almacenar las invitaciones

local exhaustTime = 10 -- Tiempo de enfriamiento en segundos
local exhaust = {} -- Tabla para almacenar los tiempos de enfriamiento por jugador

function partyinvite.onSay(player, words, param)
    local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This command is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end

    if not param or param == "" then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Usage: !partyinvite <playername>")
        return false
    end

    local invitedPlayer = Player(param)
    if invitedPlayer then
        if invitations[invitedPlayer:getId()] then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Player " .. invitedPlayer:getName() .. " already has an invitation pending.")
            return false
        end

        local party = player:getParty()
        if party then
            party:addInvite(invitedPlayer)
            invitations[invitedPlayer:getId()] = player:getId() -- Almacenamos la referencia del jugador que envió la invitación
            invitedPlayer:sendTextMessage(MESSAGE_INFO_DESCR, player:getName() .. " has invited you to join their party. Use !partyjoin to accept the invitation.")
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Invitation Party sent to [" .. invitedPlayer:getName() .. "].")
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not in a party.")
        end
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Player [" .. param .. "] not found.")
    end

    exhaust[playerId] = currentTime + exhaustTime
    return false
end

partyinvite:separator(" ")
partyinvite:register()

local partyjoin = TalkAction("!partyjoin")

local exhaustTime = 10 -- Tiempo de enfriamiento en segundos
local exhaust = {} -- Tabla para almacenar los tiempos de enfriamiento por jugador

function partyjoin.onSay(player, words, param)
    local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This command is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end

    local invitingPlayerId = invitations[playerId]
    if invitingPlayerId then
        local invitingPlayer = Player(invitingPlayerId)
        if invitingPlayer then
            local party = invitingPlayer:getParty()
            if party then
                party:addMember(player)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "You have joined [" .. invitingPlayer:getName() .. "] party.")
                invitingPlayer:sendTextMessage(MESSAGE_INFO_DESCR, "The [".. player:getName() .. "] has joined your party.")
                invitations[playerId] = nil
            else
                player:sendTextMessage(MESSAGE_INFO_DESCR, "The inviting player is not in a party anymore.")
            end
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "The inviting player is no longer online.")
        end
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You don't have an invitation to join a party.")
    end

    exhaust[playerId] = currentTime + exhaustTime
    return false
end

partyjoin:separator(" ")
partyjoin:register()

local partyleave = TalkAction("!partyleave")

local exhaustTime = 10 -- Tiempo de enfriamiento en segundos
local exhaust = {} -- Tabla para almacenar los tiempos de enfriamiento por jugador

function partyleave.onSay(player, words, param)
    local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This command is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end

    local party = player:getParty()
    if party then
        if party:getLeader():getId() ~= playerId then
            if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
                player:sendTextMessage(MESSAGE_INFO_DESCR, "You cannot leave the party while you are in combat.")
            else
                party:removeMember(player)
                player:sendTextMessage(MESSAGE_INFO_DESCR, "You have left the party.")
            end
        else
            player:sendTextMessage(MESSAGE_INFO_DESCR, "As the party leader, you cannot leave the party. Use !partydisband to disband the party.")
        end
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not in a party.")
    end

    exhaust[playerId] = currentTime + exhaustTime
    return false
end

partyleave:separator(" ")
partyleave:register()

local partybc = TalkAction("!partybc")

local exhaustTime = 10 -- Tiempo de enfriamiento en segundos
local exhaust = {} -- Tabla para almacenar los tiempos de enfriamiento por jugador

function partybc.onSay(player, words, param)
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This command is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
    if not param or param == "" then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Invalid command. Usage: !partybc [message]")
        return false
    end

    local party = player:getParty()
    if not party then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You are not in a party.")
        return false
    end

    local members = party:getMembers()
    for _, member in ipairs(members) do
        member:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Party Broadcast] " .. player:getName() .. ": " .. param)
    end

    local leader = party:getLeader()
    if leader then
        leader:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Party Broadcast] " .. player:getName() .. ": " .. param)
    end

	exhaust[playerId] = currentTime + exhaustTime
    return false
end

partybc:separator(" ")
partybc:register()

