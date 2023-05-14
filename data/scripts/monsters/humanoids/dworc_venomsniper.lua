local mType = Game.createMonsterType("Dworc Venomsniper")
local monster = {}

monster.description = "a dworc venomsniper"
monster.experience = 35
monster.outfit = {
	lookType = 216,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 80
monster.maxHealth = 80
monster.race = "blood"
monster.corpse = 6059
monster.speed = 76
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 0
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = true,
	rewardBoss = false,
	illusionable = true,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 4,
	runHealth = 15,
	healthHidden = false,
	ignoreSpawnBlock = true,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Brak brrretz!", yell = false},
	{text = "Grow truk grrrrr.", yell = false},
	{text = "Prek tars, dekklep zurk.", yell = false}
}

monster.loot = {
	{id = 2920, chance = 6000}, -- torch
	{name = "gold coin", chance = 75000, maxCount = 13},
	{name = "bronze amulet", chance = 110},
	{id = 3114, chance = 1000, maxCount = 2}, -- skull
	{name = "poison dagger", chance = 1500},
	{name = "leather armor", chance = 10000},
	{name = "poison arrow", chance = 5000, maxCount = 3},
	{name = "tribal mask", chance = 510},
	{name = "bast skirt", chance = 100},
	{name = "seeds", chance = 200}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -15},
	-- poison
	{name ="condition", condition = {type = CONDITION_POISON, interval = 2000, chance = 15, minDamage = -20, maxDamage = -40}, range = 5, shootEffect = CONST_ANI_POISON, target = false}
}

monster.defenses = {
	defense = 10,
	armor = 10
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -13},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -13},
	{type = COMBAT_HOLYDAMAGE , percent = 15},
	{type = COMBAT_DEATHDAMAGE , percent = -8}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = false},
	{type = "bleed", condition = false}
}

mType:register(monster)