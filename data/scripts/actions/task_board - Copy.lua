local guild = Action()

local level_experience = {
    [1] = {name = "Nivel 1", expMin = 0, expMax = 50},
    [2] = {name = "Nivel 2", expMin = 51, expMax = 199},
    [3] = {name = "Nivel 3", expMin = 200, expMax = 399},
	[4] = {name = "Nivel 4", expMin = 400, expMax = math.huge},
}

function guild.onUse(player, item, target, itemEx)

	local guild = player:getGuild()
	--local guild2 = target:getGuild()
    local currentLevel = guild:getLevel()
    local experienceNeeded = level_experience[currentLevel].expMax

    -- Cantidad de experiencia ganada progresivamente
	local max = 12
	local xp = math.random(1, max)
    local experienciaGanada = 12

    if currentLevel < #level_experience then
        guild:addExperience(xp)
    else
        player:say("¡Has alcanzado el máximo nivel!", TALKTYPE_MONSTER_SAY)
        experienciaGanada = 0 -- Detener la ganancia de experiencia
    end

    local newLevel = currentLevel
    while guild:getExperience() >= experienceNeeded and level_experience[newLevel + 1] do
        newLevel = newLevel + 1
        experienceNeeded = level_experience[newLevel].expMax
    end

    if newLevel > currentLevel then
        local levelName = level_experience[newLevel].name
        player:say("¡Has subido al " .. levelName .. "!", TALKTYPE_MONSTER_SAY)
        guild:addLevel(newLevel - currentLevel) -- Incrementar el nivel de manera incremental
    else
        player:say("¡Has ganado " .. xp .. " de experiencia!", TALKTYPE_MONSTER_SAY)
    end
	
	return true
end


guild:id(5925)
guild:register()



