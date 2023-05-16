local mType = Game.createMonsterType("Noxious Ripptor")
local monster = {}

monster.description = "a Noxious Ripptor"
monster.experience = 13190
monster.outfit = {
	lookType = 1558,
	lookHead = 85,
	lookBody = 1,
	lookLegs = 85,
	lookFeet = 105,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 22700
monster.maxHealth = 22700
monster.race = "blood"
monster.corpse = 39323
monster.speed = 180
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
	targetDistance = 2,
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
	{text = "Krccchht!", yell = false},
}

monster.loot = {
	{name = "Crystal Coin", chance = 26770, maxCount = 2},
	{name = "Ripptor Scales", chance = 12850},
	{name = "Ultimate Health Potion", chance = 10570, maxCount = 2},
	{name = "Ripptor Claw", chance = 8280, maxCount = 2},
	{name = "Serpent Sword", chance = 1440},
	{name = "Sacred Tree Amulet", chance = 1360},
	{name = "Muck Rod", chance = 1290},
	{name = "Terra Legs", chance = 750},
	{name = "Wooden Spellbook", chance = 450},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 300, maxDamage = -801},
	{name ="combat", interval = 3000, chance = 47, type = COMBAT_PHYSICALDAMAGE, minDamage = -800, maxDamage = -1500, effect = CONST_ME_YELLOWSMOKE, target = true},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -475, range = 7, shootEffect = CONST_ANI_ENERGYBALL, effect = CONST_ME_ENERGYAREA, target = true},
	{name ="combat", interval = 2000, chance = 31, type = COMBAT_ENERGYDAMAGE, minDamage = -800, maxDamage = -1500, radius = 4, effect = CONST_ME_YELLOWENERGY, target = true},
}

monster.defenses = {
	defense = 110,
	armor = 82,
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 20},
	{type = COMBAT_ENERGYDAMAGE, percent = 10},
	{type = COMBAT_EARTHDAMAGE, percent = 10},
	{type = COMBAT_FIREDAMAGE, percent = 0},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE , percent = -10},
	{type = COMBAT_DEATHDAMAGE , percent = -10}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)