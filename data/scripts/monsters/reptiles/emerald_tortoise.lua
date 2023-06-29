local mType = Game.createMonsterType("Emerald Tortoise")
local monster = {}

monster.description = "a Emerald Tortoise"
monster.experience = 12129
monster.outfit = {
	lookType = 1550,
	lookHead = 85,
	lookBody = 1,
	lookLegs = 85,
	lookFeet = 105,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 22300
monster.maxHealth = 22300
monster.race = "blood"
monster.corpse = 39291
monster.speed = 358
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	ignoreSpawnBlock = true,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Shllpp...", yell = false},
}

monster.loot = {
	{name = "Emerald Tortoise Shell", chance = 28590},
	{name = "Crystal Coin", chance = 15520, maxCount = 3},
	{name = "Great Spirit Potion", chance = 13360, maxCount = 2},
	{name = "Blue Crystal Shard", chance = 4030},
	{name = "Green Crystal Fragment", chance = 3950},
	{name = "Violet Gem", chance = 3950},
	{name = "Red Crystal Fragment", chance = 3350},
	{name = "Yellow Gem", chance = 3320},
	{name = "White Pearl", chance = 3240},
	{name = "Green Crystal Shard", chance = 2900},
	{name = "Green Gem", chance = 2870},
	{name = "Orichalcum Pearl", chance = 2640, maxCount = 2},
	{id = 282, chance = 2420}, -- Giant Shimmering Pearl (Green)
	{id = 3039, chance = 2420}, -- Red Gem
	{name = "Black Pearl", chance = 2160, maxCount = 2},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 450, maxDamage = -500},
	{name ="combat", interval = 2000, chance = 40, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -500, range = 5, shootEffect = CONST_ANI_ENERGY, target = true},
	{name ="lavafungus ring", interval = 2000, chance = 20, minDamage = -600, maxDamage = -650},
}

monster.defenses = {
	defense = 110,
	armor = 97,
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 20},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = 10},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = 10},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)