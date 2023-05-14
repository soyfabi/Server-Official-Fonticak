local mType = Game.createMonsterType("Ink Blob")
local monster = {}

monster.description = "an ink blob"
monster.experience = 14450
monster.outfit = {
	lookType = 1064,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 9500
monster.maxHealth = 9500
monster.race = "ink"
monster.corpse = 28601
monster.speed = 190
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8
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
	canPushCreatures = false,
	staticAttackChance = 85,
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
}

monster.loot = {
	{name = "platinum coin", chance = 120000, maxCount = 4},
	{name = "envenomed arrow", chance = 1200, maxCount = 14},
	{id = 28568, chance = 1200, maxCount = 4}, -- inkwell
	{name = "poisonous slime", chance = 1200, maxCount = 4},
	{name = "small diamond", chance = 1200, maxCount = 4},
	{name = "small topaz", chance = 1200, maxCount = 4},
	{id = 282, chance = 900, maxCount = 4}, -- giant shimmering pearl (brown)
	{name = "blue gem", chance = 950, maxCount = 4},
	{name = "terra boots", chance = 850, maxCount = 4},
	{name = "terra hood", chance = 980, maxCount = 4},
	{name = "protection amulet", chance = 1200, maxCount = 4},
	{name = "sacred tree amulet", chance = 1200, maxCount = 4},
	{name = "springsprout rod", chance = 790, maxCount = 4},
	{name = "stone skin amulet", chance = 1200, maxCount = 4},
	{name = "terra legs", chance = 650, maxCount = 4},
	{name = "terra mantle", chance = 550, maxCount = 4},
	{name = "clay lump", chance = 1200, maxCount = 4},
	{name = "terra amulet", chance = 1200, maxCount = 4}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, skill = 45, attack = 40, condition = {type = CONDITION_POISON, totalDamage = 280, interval = 4000}},
	-- poison
	{name ="condition", condition = {type = CONDITION_POISON, interval = 2000, chance = 13, minDamage = -400, maxDamage = -580}, radius = 4, effect = CONST_ME_POISONAREA, target = false},
	{name ="combat", interval = 2000, chance = 11, type = COMBAT_EARTHDAMAGE, minDamage = -285, maxDamage = -480, radius = 3, shootEffect = CONST_ANI_ENVENOMEDARROW, effect = CONST_ME_GREEN_RINGS, target = true},
	{name ="combat", interval = 2000, chance = 10, type = COMBAT_EARTHDAMAGE, minDamage = -260, maxDamage = -505, range = 7, shootEffect = CONST_ANI_POISON, effect = CONST_ME_POISONAREA, target = true}
}

monster.defenses = {
	defense = 15,
	armor = 15,
	{name ="combat", interval = 2000, chance = 5, type = COMBAT_HEALING, minDamage = 20, maxDamage = 30, effect = CONST_ME_MAGIC_BLUE, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -8},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = false},
	{type = "bleed", condition = false}
}

mType:register(monster)
