local mType = Game.createMonsterType("Melting Frozen Horror")
local monster = {}

monster.description = "a melting frozen horror"
monster.experience = 0
monster.outfit = {
	lookType = 261,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 70000
monster.maxHealth = 70000
monster.race = "undead"
monster.corpse = 7282
monster.speed = 240
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 5
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.events = {
	"MeltingDeath"
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Chrrrrrk! Chrrrk!", yell = false}
}

monster.loot = {
	{id = 3031, chance = 100000, maxCount = 100}, -- gold coin
	{id = 3031, chance = 100000, maxCount = 11}, -- gold coin
	{id = 9661, chance = 14111}, -- frosty heart
	{id = 7441, chance = 5100}, -- ice cube
	{id = 3284, chance = 320}, -- ice rapier
	{id = 7449, chance = 580}, -- crystal sword
	{id = 3028, chance = 730}, -- small diamond
	{id = 16120, chance = 9660, maxCount = 5}, -- violet crystal shard
	{id = 3041, chance = 5000}, -- blue gem
	{id = 7643, chance = 19500, maxCount = 3}, -- ultimate health potion
	{id = 16121, chance = 9660, maxCount = 5}, -- green crystal shard
	{id = 7459, chance = 9660}, -- pair of earmuffs
	{id = 23518, chance = 9660}, -- spark sphere
	{id = 3333, chance = 9660}, -- crystal mace
	{id = 16160, chance = 9660}, -- crystalline sword
	{id = 16175, chance = 200}, -- shiny blade
	{id = 14247, chance = 200}, -- ornate crossbow
	{id = 8059, chance = 500}, -- frozen plate
	{id = 24958, chance = 500, unique = true}, -- part of a rune
	{id = 19363, chance = 200}, -- runic ice shield
	{id = 22721, chance = 100000}, -- gold token
	{id = 22516, chance = 100000} -- silver token
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 100, attack = 60},
	{name ="hirintror freeze", interval = 2000, chance = 15, target = false},
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_ICEDAMAGE, minDamage = -75, maxDamage = -150, range = 7, radius = 3, shootEffect = CONST_ANI_ICE, effect = CONST_ME_BLOCKHIT, target = true},
	{name ="ice golem paralyze", interval = 2000, chance = 11, target = false},
	{name ="hirintror skill reducer", interval = 2000, chance = 10, target = false}
}

monster.defenses = {
	defense = 60,
	armor = 60,
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_HEALING, radius = 7, effect = CONST_ME_BLOCKHIT, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 100},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = -50}
}

monster.heals = {
	{type = COMBAT_ICEDAMAGE, percent = 100}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
