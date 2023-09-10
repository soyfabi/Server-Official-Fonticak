local CHANNEL_GLOBAL = 2

function calculateMuteTicks(minutes)
    return minutes * 60 * 1000
end

function formatTime(duration)
    local hours = math.floor(duration / 3600)
    local minutes = math.floor((duration % 3600) / 60)
    local seconds = duration % 60
    local timeString = ""

    if hours > 0 then
        timeString = hours .. " hour" .. (hours > 1 and "s" or "")
        if minutes > 0 or seconds > 0 then
            timeString = timeString .. " and "
        end
    end

    if minutes > 0 then
        timeString = timeString .. minutes .. " minute" .. (minutes > 1 and "s" or "")
        if seconds > 0 then
            timeString = timeString .. " and "
        end
    end

    if seconds > 0 then
        timeString = timeString .. seconds .. " second" .. (seconds > 1 and "s" or "")
    end

    return timeString
end

function onSpeak(player, type, message)
    local playerAccountType = player:getAccountType()
    if player:getLevel() < 20 then
        player:sendCancelMessage("You may not speak into channels as long as you are on level 20.")
        return false
    end
    
    if player:getCondition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT, CHANNEL_GLOBAL) then
        local muteCondition = player:getCondition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT, CHANNEL_GLOBAL)
        local remainingTicks = muteCondition:getTicks()
        local remainingTime = ""

        local remainingMinutes = math.floor(remainingTicks / 60000)
        local remainingSeconds = math.floor((remainingTicks % 60000) / 1000)

        if remainingMinutes > 0 then
            remainingTime = " Mute will last for " .. formatTime(remainingMinutes * 60 + remainingSeconds) .. "."
        else
            remainingTime = " Mute will last for " .. formatTime(remainingSeconds) .. "."
        end

        player:sendCancelMessage("You are muted from the Global Channel for using it inappropriately." .. remainingTime)
        return false
	end
	
    if playerAccountType >= ACCOUNT_TYPE_TUTOR then
        local muteCommand, muteDuration = string.match(message, "^!mute ([^,%s]+)%s*,%s*(%d+)$")

        if muteCommand then
            local target = Player(muteCommand)
            muteDuration = tonumber(muteDuration)
            if target then
                if playerAccountType > target:getAccountType() then
                    local muted = Condition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT)
                    muted:setParameter(CONDITION_PARAM_SUBID, CHANNEL_GLOBAL)
                    muted:setParameter(CONDITION_PARAM_TICKS, calculateMuteTicks(muteDuration))

                    if not target:getCondition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT, CHANNEL_GLOBAL) then
                        target:addCondition(muted)
                        sendChannelMessage(CHANNEL_GLOBAL, TALKTYPE_CHANNEL_R1, target:getName() .. " has been muted by " .. player:getName() .. " for using Global Channel inappropriately. Mute will last " .. muteDuration .. " minutes.")
                    else
                        player:sendCancelMessage("That player is already muted.")
                    end
                else
                    player:sendCancelMessage("You are not authorized to mute that player.")
                end
            else
                player:sendCancelMessage(RETURNVALUE_PLAYERWITHTHISNAMEISNOTONLINE)
            end
            return false
        elseif string.sub(message, 1, 8) == "!unmute " then
            local targetName = string.sub(message, 9)
            local target = Player(targetName)
            if target then
                if playerAccountType > target:getAccountType() then
                    if target:getCondition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT, CHANNEL_GLOBAL) then
                        target:removeCondition(CONDITION_CHANNELMUTEDTICKS, CONDITIONID_DEFAULT, CHANNEL_GLOBAL)
                        sendChannelMessage(CHANNEL_GLOBAL, TALKTYPE_CHANNEL_R1, target:getName() .. " has been unmuted by " .. player:getName() .. ".")
                    else
                        player:sendCancelMessage("That player is not muted.")
                    end
                else
                    player:sendCancelMessage("You are not authorized to unmute that player.")
                end
            else
                player:sendCancelMessage(RETURNVALUE_PLAYERWITHTHISNAMEISNOTONLINE)
            end
            return false
        end
    end

    if type == TALKTYPE_CHANNEL_Y then
        if playerAccountType >= ACCOUNT_TYPE_GAMEMASTER then
            type = TALKTYPE_CHANNEL_R1 -- Talk GM, CM, GOD
        end
    elseif type == TALKTYPE_CHANNEL_O then -- TALK TUTOR
        if playerAccountType < ACCOUNT_TYPE_GAMEMASTER then
            type = TALKTYPE_CHANNEL_Y
        end
    elseif type == TALKTYPE_CHANNEL_R1 then
        if playerAccountType < ACCOUNT_TYPE_GAMEMASTER and not player:hasFlag(PlayerFlag_CanTalkRedChannel) then
            type = TALKTYPE_CHANNEL_Y -- Talk Player
        end
    end
    return type
end