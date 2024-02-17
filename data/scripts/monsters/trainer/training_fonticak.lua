local mType = Game.createMonsterType("Training Fonticak")
local monster = {}

monster.description = "a training fonticak"
monster.experience = 0
monster.outfit = {
	lookType = 1661,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 150000
monster.maxHealth = 150000
monster.race = "blood"
monster.corpse = 0
monster.speed = 0
monster.manaCost = 0

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
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	ignoreSpawnBlock = true,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = true
}

monster.light = {
	level = 100,
	color = 215
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "Fonticak the best server!", yell = false},
	{text = "Recommend to others", yell = false},
	{text = "Visit Discord or Website - www.fonticak-server.com", yell = false}
}

monster.loot = {
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -12, maxDamage = -15},
	{name ="combat", interval = 5000, chance = 30, type = COMBAT_ENERGYDAMAGE, minDamage = -12, maxDamage = -15, range = 1, shootEffect = CONST_ANI_ENERGY, target = true},
	{name ="combat", interval = 5000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -12, maxDamage = -15, range = 1, shootEffect = CONST_ANI_FIRE, target = true},
}

monster.defenses = {
	defense = 10,
	armor = 10,
	{name ="combat", interval = 4000, chance = 75, type = COMBAT_HEALING, minDamage = 4000, maxDamage = 8500, range = 1, radius = 3, effect = CONST_ME_MAGIC_BLUE, target = false},
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
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
