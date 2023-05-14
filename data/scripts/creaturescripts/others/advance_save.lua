local config = {
	heal = true,
	save = true,
}

local advanceSave = CreatureEvent("AdvanceSave")
function advanceSave.onAdvance(player, skill, oldLevel, newLevel)
	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		return true
	end

	if config.heal then
		player:addHealth(player:getMaxHealth())
	end

	if config.save then
		player:save()
	end
	return true
end
advanceSave:register()

local adv = CreatureEvent("AdvanceSave")
function adv.onLogin(player)
	player:registerEvent("AdvanceSave")
	return true
end

adv:register()
