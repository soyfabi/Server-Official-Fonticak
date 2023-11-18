local mType = Game.createMonsterType("Feral Werecrocodile")
local monster = {}

monster.description = "a Feral Werecrocodile"
monster.experience = 5080
monster.outfit = {
	lookType = 1647,
	lookHead = 116,
	lookBody = 95,
	lookLegs = 19,
	lookFeet = 21,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 6400
monster.maxHealth = 6400
monster.race = "undead"
monster.corpse = 43767
monster.speed = 220
monster.manaCost = 0

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
	runHealth = 800,
	healthHidden = false,
	ignoreSpawnBlock = true,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {

}

monster.loot = {
	{ name = "gold coin", chance = 13222, maxCount = 100 },
	{ name = "platinum coin", chance = 7601, maxCount = 21 },
	{ name = "werecrocodile tongue", chance = 13336, maxCount = 1 },
	{ name = "ham", chance = 9592, maxCount = 2 },
	{ name = "war hammer", chance = 5086, maxCount = 1 },
	{ name = "moonlight crystals", chance = 11701, maxCount = 1 },
	{ name = "golden sun coin", chance = 7323, maxCount = 1 },
	{ name = "violet gem", chance = 12362, maxCount = 1 },
	{ name = "ornate crossbow", chance = 8599, maxCount = 1 },
	{ name = "sun brooch", chance = 5825, maxCount = 1 },
	{ name = "terra mantle", chance = 12902, maxCount = 1 },
	{ name = "swamplair armor", chance = 10792, maxCount = 1 },
}

monster.attacks = {
	{ name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -750, effect = CONST_ME_DRAWBLOOD },
	{ name ="combat", interval = 6000, chance = 30, type = COMBAT_HOLYDAMAGE, minDamage = -450, maxDamage = -750, length = 8, spread = 3, effect = CONST_ME_HOLYAREA, target = false },
	{ name ="combat", interval = 2750, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -800, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name ="combat", interval = 2500, chance = 22, type = COMBAT_DEATHDAMAGE, minDamage = -400, maxDamage = -500, radius = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name ="combat", interval = 3300, chance = 24, type = COMBAT_ICEDAMAGE, minDamage = -250, maxDamage = -350, length = 4, spread = 0, effect = CONST_ME_ICEATTACK, target = false },
	{ name ="combat", interval = 3000, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -500, radius = 4, effect = CONST_ME_BIGCLOUDS, target = false }
}

monster.defenses = {
	defense = 85,
	armor = 85
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 20 },
	{ type = COMBAT_FIREDAMAGE, percent = 35 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = -15 },
	{ type = COMBAT_HOLYDAMAGE , percent = -20 },
	{ type = COMBAT_DEATHDAMAGE , percent = 60 }
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }
}

mType:register(monster)
