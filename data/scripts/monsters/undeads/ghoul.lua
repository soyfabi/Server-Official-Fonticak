local mType = Game.createMonsterType("Ghoul")
local monster = {}

monster.description = "a ghoul"
monster.experience = 85
monster.outfit = {
	lookType = 18,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 100
monster.maxHealth = 100
monster.race = "blood"
monster.corpse = 5976
monster.speed = 72
monster.manaCost = 450

monster.changeTarget = {
	interval = 4000,
	chance = 0
}

monster.flags = {
	summonable = true,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	ignoreSpawnBlock = true,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{id = 2920, chance = 5000}, -- torch
	{name = "gold coin", chance = 68000, maxCount = 30},
	{id = 3052, chance = 180}, -- life ring
	{id = 3114, chance = 240}, -- skull
	{name = "viking helmet", chance = 990},
	{name = "scale armor", chance = 1000},
	{name = "worm", chance = 9600, maxCount = 2},
	{name = "brown piece of cloth", chance = 1000},
	{name = "rotten piece of cloth", chance = 14470},
	{name = "ghoul snack", chance = 5130},
	{name = "pile of grave earth", chance = 950},
	{id = 23986, chance = 1000} -- heavy old tome
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -70},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -15, maxDamage = -27, range = 1, radius = 1, effect = CONST_ME_SMALLCLOUDS, target = true}
}

monster.defenses = {
	defense = 15,
	armor = 15,
	{name ="combat", interval = 2000, chance = 5, type = COMBAT_HEALING, minDamage = 9, maxDamage = 15, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 30},
	{type = COMBAT_EARTHDAMAGE, percent = 20},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
	{type = COMBAT_ICEDAMAGE, percent = 10},
	{type = COMBAT_HOLYDAMAGE , percent = -25},
	{type = COMBAT_DEATHDAMAGE , percent = 100}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
