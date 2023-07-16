local config = {
    channelId = 5,

    subTypes = {
        { count = 1, message = 'was killed by:' },
        { count = 2, message = 'was devoured by:' },
		{ count = 3, message = 'was executed by:' },
        { count = 5, message = 'was demolished by:' },
        { count = 8, message = 'was sentenced by:' },
        { count = 10, message = 'was slaughtered by:' }
    }
}

local creatureEvent = CreatureEvent("DeathChannelOnDeath")

function creatureEvent.onDeath(player)
    local attackersCount, description, creatures = 0, {}, {}

    for uid, cb in pairs(player:getDamageMap()) do
        local attacker = Creature(uid)
        if attacker then
            if attacker:isPlayer() then
                attackersCount = attackersCount + 1
                table.insert(description, { type = "player", name = attacker:getName(), level = attacker:getLevel() })
            elseif attacker:isMonster() then
                local attackerName = attacker:getName()
                if not creatures[attackerName] then
                    local master = attacker:getMaster()
                    if master then
                        attackersCount = attackersCount + 1
                        table.insert(description, { type = "monster", name = attackerName, level = nil, master = master:getName(), count = 1 })
                    else
                        attackersCount = attackersCount + 1
                        table.insert(description, { type = "monster", name = attackerName, level = nil, master = nil, count = 1 })
                    end
                    creatures[attackerName] = #description
                else
                    description[creatures[attackerName]].count = description[creatures[attackerName]].count + 1
                end
            end
        end
    end

    local subType = nil
    local channelType = TALKTYPE_CHANNEL_O -- Normal Channel

    for i, info in ipairs(config.subTypes) do
        if attackersCount >= info.count and (i == #config.subTypes or attackersCount < config.subTypes[i+1].count) then
            subType = info.message
            break
        end
    end

    if subType == nil then
        subType = config.subTypes[#config.subTypes].message
    end

    if attackersCount >= 5 then
        channelType = TALKTYPE_CHANNEL_R1
    elseif attackersCount >= 2 then
        channelType = TALKTYPE_CHANNEL_Y
    end

    table.sort(description, function(a, b)
        return a.type == "monster" and b.type == "player"
    end)

    local attackerInfo = ""
    for i, desc in ipairs(description) do
        if desc.type == "player" then
            if i == attackersCount and i > 1 then
                attackerInfo = attackerInfo .. " and"
            elseif i > 1 then
                attackerInfo = attackerInfo .. ","
            end
            attackerInfo = attackerInfo .. string.format(" %s [%d]", desc.name, desc.level)
        elseif desc.type == "monster" then
            if i == attackersCount and i > 1 then
                attackerInfo = attackerInfo .. " and"
            elseif i > 1 then
                attackerInfo = attackerInfo .. ","
            end
            local monsterInfo = desc.count >= 2 and string.format(" %sx %s", desc.count, desc.name) or string.format(" %s", desc.name)
            if desc.master then
                monsterInfo = monsterInfo .. string.format(" summoned by %s", desc.master)
            end
            attackerInfo = attackerInfo .. monsterInfo
        end
    end

    local totalAttackersMessage = attackersCount > 1 and string.format(" (%d attackers)", attackersCount) or ""

    if attackersCount > 1 then
        totalAttackersMessage = string.format(" (%d attackers)", attackersCount)
    end

    local channelMessage = string.format('%s [%d] %s%s%s.', player:getName(), player:getLevel(), subType, attackerInfo, totalAttackersMessage)

    local guild = player:getGuild()
    sendChannelMessage(config.channelId, channelType, channelMessage)
	if guild then
    sendGuildChannelMessage(guild:getId(), channelType, channelMessage)
	end
end

creatureEvent:register()

local creatureEvent = CreatureEvent("DeathChannelOnLogin")

function creatureEvent.onLogin(player)
    player:registerEvent("DeathChannelOnDeath")
    return true
end

creatureEvent:register()