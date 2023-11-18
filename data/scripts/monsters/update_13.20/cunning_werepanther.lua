local mType = Game.createMonsterType("Cunning Werepanther")
local monster = {}

monster.description = "a Cunning Werepanther"
monster.experience = 3620
monster.outfit = {
	lookType = 1648,
	lookHead = 18,
	lookBody = 124,
	lookLegs = 74,
	lookFeet = 81,
	lookAddons = 1,
	lookMount = 0
}

monster.health = 4300
monster.maxHealth = 4300
monster.race = "undead"
monster.corpse = 43959
monster.speed = 250
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
	runHealth = 0,
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
	{ name = "gold coin", chance = 10558, maxCount = 80 },
	{ name = "platinum coin", chance = 8694, maxCount = 11 },
	{ name = "werepanther claw", chance = 5485, maxCount = 1 },
	{ name = "golden sickle", chance = 5970, maxCount = 1 },
	{ name = "small topaz", chance = 7513, maxCount = 4 },
	{ name = "meat", chance = 12545, maxCount = 2 },
	{ name = "yellow gem", chance = 14190, maxCount = 1 },
	{ name = "moonlight crystals", chance = 13613, maxCount = 1 },
	{ name = "lightning headband", chance = 11638, maxCount = 1 },
	{ name = "lightning pendant", chance = 5298, maxCount = 1 },
	{ name = "ripper lance", chance = 6667, maxCount = 1 },
	{ name = "fur armor", chance = 8253, maxCount = 1 },
	{ name = "gemmed figurine", chance = 13628, maxCount = 1 },
	{ name = "werepanther trophy", chance = 5424, maxCount = 1 },
}

monster.attacks = {
	{ name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name ="combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -400, maxDamage = -500, radius = 2, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name ="combat", interval = 2000, chance = 14, type = COMBAT_HOLYDAMAGE, minDamage = -290, maxDamage = -360, length = 5, spread = 3, effect = CONST_ME_BLOCKHIT, target = false }
}

monster.defenses = {
	defense = 100,
	armor = 72
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = 40 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE , percent = 25 },
	{ type = COMBAT_DEATHDAMAGE , percent = -20 }
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }
}

mType:register(monster)
