--[[ Find on sources (Game.cpp): int32_t realManaChange = targetPlayer->getMana();
	Bellow of: realManaChange = targetPlayer->getMana() - realManaChange;
	Add: if (realManaChange > 0 && !targetPlayer->isInGhostMode()) {
		addAnimatedText(fmt::format("+{:d}", realManaChange), targetPlayer->getPosition(), TEXTCOLOR_DARKPURPLE);
		}
]]--

local exhaust = {}
local potions = {
	-- Mana Potion --
	[268] = {vocations = {1,2,3,4,5,6,7,8}, exhaustTime = 700, manaMin = 120, manaMax = 220, healthMin = 0, healthMax = 0},
	-- Strong Mana Potion --
	[237] = {vocations = {1,2,3,5,6,7}, exhaustTime = 700, manaMin = 275, manaMax = 325, healthMin = 0, healthMax = 0},
	-- Great Mana Potion --
	[238] = {vocations = {1,2,5,6}, exhaustTime = 700, manaMin = 385, manaMax = 455, healthMin = 0, healthMax = 0},
	-- Ultimate Mana Potion --
	[23373] = {vocations = {1,2,5,6}, exhaustTime = 700, manaMin = 455, manaMax = 520, healthMin = 0, healthMax = 0},
	-- Health Potion --
	[266] = {vocations = {1,2,3,4,5,6,7,8}, exhaustTime = 700, manaMin = 0, manaMax = 0, healthMin = 80, healthMax = 130},
	-- Strong Health Potion --
	[236] = {vocations = {3,4,7,8}, exhaustTime = 700, manaMin = 0, manaMax = 0, healthMin = 245, healthMax = 325},
	-- Great Health Potion --
	[239] = {vocations = {4,8}, exhaustTime = 700, manaMin = 0, manaMax = 0, healthMin = 360, healthMax = 410},
	-- Ultimate Health Potion --
	[7643] = {vocations = {4,8}, exhaustTime = 700, manaMin = 0, manaMax = 0, healthMin = 455, healthMax = 530},
	-- Supreme Health Potion --
	[23375] = {vocations = {4,8}, exhaustTime = 700, manaMin = 0, manaMax = 0, healthMin = 530, healthMax = 620},
	-- Great Spirit Potion --
	[7642] = {vocations = {3,7}, exhaustTime = 700, manaMin = 280, manaMax = 315, healthMin = 390, healthMax = 480},
	-- Ultimate Spirit Potion --
	[23374] = {vocations = {3,7}, exhaustTime = 700, manaMin = 300, manaMax = 350, healthMin = 415, healthMax = 520},
}

---- Potions ---
local mana_potion = Action()
function mana_potion.onUse(cid, item, fromPosition, target, toPosition, isHotkey)
	
	local player = Player(cid)
	local playerId = player:getId()
	local currentTime = os.mtime()
	
	if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("Your potions are still on cooldown. (MS:" .. exhaust[playerId] - currentTime .. ")")
		return true
	end
	
	local potion = potions[item:getId()]
	
	if not isInArray(potion.vocations, getPlayerVocation(cid)) then
		player:say("You are not the necessary vocation to use this potion.")
		return true
	end
	
	targetPlayer = Player(target)
	if not targetPlayer then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You may only use this on players!")
		return true
	end
	
	if potion.healthMin > 0 then
		local health_add = math.random(potion.healthMin, potion.healthMax) 
		targetPlayer:addHealth(health_add)
		targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
	
	if potion.manaMin > 0 then
		local mana_add = math.random(potion.manaMin, potion.manaMax) 
		targetPlayer:addMana(mana_add)
		targetPlayer:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end
	
	exhaust[playerId] = currentTime + potion.exhaustTime
	
	if not configManager.getBoolean(configKeys.REMOVE_POTION_CHARGES) then
		return true
	end
	item:remove(1)
	return true
end

for itemId, _ in pairs(potions) do
	mana_potion:id(itemId)
end
mana_potion:register()


-------POTIONS SPECIAL BUFFER-------


local berserk = Condition(CONDITION_ATTRIBUTES)
berserk:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
berserk:setParameter(CONDITION_PARAM_SKILL_MELEE, 5)
berserk:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
berserk:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local mastermind = Condition(CONDITION_ATTRIBUTES)
mastermind:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
mastermind:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 3)
mastermind:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local bullseye = Condition(CONDITION_ATTRIBUTES)
bullseye:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
bullseye:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 5)
bullseye:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
bullseye:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local antidote = Combat()
antidote:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
antidote:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
antidote:setParameter(COMBAT_PARAM_DISPEL, CONDITION_POISON)
antidote:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
antidote:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)

local function magicshield(player)
local condition = Condition(CONDITION_MANASHIELD)
condition:setParameter(CONDITION_PARAM_TICKS, 60000)
condition:setParameter(CONDITION_PARAM_MANASHIELD, math.min(player:getMaxMana(), 300 + 7.6 * player:getLevel() + 7 * player:getMagicLevel()))
player:addCondition(condition)
end

local potions = {
	[6558] = {
		transform = {
			id = {236, 237}
		},
		effect = CONST_ME_DRAWBLOOD
	},
	[7439] = {
		vocations = {
			VOCATION.BASE_ID.KNIGHT
		},
		condition = berserk,
		effect = CONST_ME_MAGIC_RED,
		description = "Only knights may drink this potion.",
		text = "You feel stronger."
	},
	[7440] = {
		vocations = {
			VOCATION.BASE_ID.SORCERER,
			VOCATION.BASE_ID.DRUID
		},
		condition = mastermind,
		effect = CONST_ME_MAGIC_BLUE,
		description = "Only sorcerers and druids may drink this potion.",
		text = "You feel smarter."
	},
	[7443] = {
		vocations = {
			VOCATION.BASE_ID.PALADIN
		},
		condition = bullseye,
		effect = CONST_ME_MAGIC_GREEN,
		description = "Only paladins may drink this potion.",
		text = "You feel more accurate."
	},
	[35563] = {
		vocations = {
			VOCATION.BASE_ID.SORCERER,
			VOCATION.BASE_ID.DRUID
		},
		level = 14,
		func = magicshield,
		effect = CONST_ME_ENERGYAREA,
		description = "Only sorcerers and druids of level 14 or above may drink this potion.",
	}
}

local flaskPotion = Action()

local exhaust = {}
local exhaustTime = 60

function flaskPotion.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if type(target) == "userdata" and not target:isPlayer() then
		return false
	end

	-- Delay potion
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end

	local potion = potions[item:getId()]
	if potion.level and player:getLevel() < potion.level or potion.vocations and not table.contains(potion.vocations, player:getVocation():getName()) and not (player:getGroup():getId() >= 2) then
		player:say(potion.description, MESSAGE_POTION)
		return true
	end

	if potion.combat then
		if potion.combat then
			potion.combat:execute(target, Variant(target:getId()))
		end

		if not potion.effect then
			target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		end
	end

	-- Delay potion
	exhaust[playerId] = currentTime + exhaustTime
	
	if potion.func then
		potion.func(player)
		player:say("Aaaah...", MESSAGE_POTION)
		player:getPosition():sendMagicEffect(potion.effect)
	end

	if potion.condition then
		player:addCondition(potion.condition)
		player:say(potion.text, MESSAGE_POTION)
		player:getPosition():sendMagicEffect(potion.effect)
	end

	if potion.transform then
		if item:getCount() >= 1 then
			item:remove(1)
			player:addItem(potion.transform.id[math.random(#potion.transform.id)], 1)
			item:getPosition():sendMagicEffect(potion.effect)
			return true
		end
	end

	if not configManager.getBoolean(configKeys.REMOVE_POTION_CHARGES) then
		item:remove(1)
		return true
	end
	
	item:remove(1)
	return true
end

for index, value in pairs(potions) do
	flaskPotion:id(index)
end

flaskPotion:register()











