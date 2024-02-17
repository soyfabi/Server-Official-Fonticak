local checkInterval = 15 -- seconds (recommend like 5+ minutes inbetween checks. getting all online players is a fairly expensive operation.)

local topPlayers = {
    {playerId = 0, monsterId = 0, position = Position(32375, 32209, 7)},  -- only edit the position of where the monster will spawn
    {playerId = 0, monsterId = 0, position = Position(32373, 32211, 7)},
    {playerId = 0, monsterId = 0, position = Position(32377, 32211, 7)}  -- if you want to show more then 3 players, just keep adding more into the table.
}


local function setMonsterDefaultSettings(monster)
    monster:rename("Top Player [LvL: ??]", "a top online placeholder creature")
    local outfit = monster:getOutfit()
    outfit.lookType = 0
    outfit.lookTypeEx = 32589
	monster:changeSpeed(-monster:getSpeed())
    monster:setOutfit(outfit)
end

local function createTopScoreMonster(index)
    local monster = Game.createMonster("deer", topPlayers[index].position, false, true)
    monster:setDropLoot(false)
    topPlayers[index].monsterId = monster:getId()
    setMonsterDefaultSettings(monster)
    return monster
end


local globalevent = GlobalEvent("onThink_showTopOnlinePlayers")

function globalevent.onThink(interval)
    local onlinePlayers = Game.getPlayers()
    
    local players = {}
    local seenIds = {}
    
    for k, v in ipairs(topPlayers) do
        local player = Player(v.playerId)
        if player and not seenIds[v.playerId] then
            players[#players + 1] = {level = player:getLevel(), id = v.playerId}
            seenIds[v.playerId] = true
        else
            v.playerId = 0
        end
    end    
    for _, player in pairs(onlinePlayers) do
        local playerId = player:getId()
        if not seenIds[playerId] and not player:getGroup():getAccess() then
            players[#players + 1] = {level = player:getLevel(), id = playerId}
            seenIds[playerId] = true
        end
    end
    table.sort(players, function(a, b) return a.level > b.level    end)
    
    for k, v in ipairs(topPlayers) do
        local monster = Monster(v.monsterId)
        if players[k] then
            v.playerId = players[k].id
            local player = Player(v.playerId)
            
            if not monster then
                monster = createTopScoreMonster(k)
            end
            
            local newName = string.format("%s [LvL: %s]", player:getName(), players[k].level)
            monster:rename(newName, "the current #" .. k .. " online player " .. newName)
            local outfit = player:getOutfit()
            monster:setOutfit(outfit)
        else
            if monster then
                setMonsterDefaultSettings(monster)
            end
        end
    end
    return true
end

globalevent:interval(checkInterval * 60 * 1000)
globalevent:register()


local globalevent = GlobalEvent("onStartup_showTopOnlinePlayers")

function globalevent.onStartup()
    for k, v in pairs(topPlayers) do
        createTopScoreMonster(k)
    end
    return true
end

globalevent:register()