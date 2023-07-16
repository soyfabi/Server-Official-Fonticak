local exhaust = {}
local exhaustTime = 60

local guildoutfit = TalkAction("!guildoutfit", "!gooutfit")

function guildoutfit.onSay(player, words, param)
    if not player:getGuild() then
        player:sendCancelMessage("You don't have a guild.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This command is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end

    if player:getGuildLevel() == 1 then
        player:sendCancelMessage("You need to be a Vice-Leader or Leader to exchange the outfit of the guild.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local guild = player:getGuild()
    local outfit = player:getOutfit()

    for _, members in ipairs(guild:getMembersOnline()) do
        local newOutfit = outfit
        if(not members:hasOutfit(outfit.lookType, outfit.lookAddons)) then
            local tmpOutfit = members:getOutfit()
            newOutfit.lookAddons = 0
            if(not members:hasOutfit(outfit.lookType, 0)) then
                newOutfit.lookType = tmpOutfit.lookType
            end
        end

        members:getPosition():sendMagicEffect(CONST_ME_GROUNDSHAKER)
		members:setOutfit(newOutfit)
        members:sendTextMessage(MESSAGE_INFO_DESCR, "The player [".. player:getName().. "] has changed the colors of the outfit.")
    end

    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    exhaust[playerId] = currentTime + exhaustTime
    return true
end

guildoutfit:register()