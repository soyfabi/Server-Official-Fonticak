local mType = Game.createMonsterType("Weretiger")
local monster = {}

monster.description = "a Weretiger"
monster.experience = 3920
monster.outfit = {
	lookType = 1646,
	lookHead = 78,
	lookBody = 57,
	lookLegs = 113,
	lookFeet = 94,
	lookAddons = 1,
	lookMount = 0
}

monster.health = 5000
monster.maxHealth = 5000
monster.race = "undead"
monster.corpse = 43750
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
	{ name = "gold coin", chance = 5019, maxCount = 100 },
	{ name = "platinum coin", chance = 11510, maxCount = 13 },
	{ name = "weretiger tooth", chance = 9948, maxCount = 1 },
	{ name = "meat", chance = 13813, maxCount = 4 },
	{ name = "furry club", chance = 8523, maxCount = 1 },
	{ name = "violet crystal shard", chance = 6028, maxCount = 1 },
	{ name = "knight armor", chance = 5692, maxCount = 1 },
	{ name = "moonlight crystals", chance = 11494, maxCount = 1 },
	{ name = "angelic axe", chance = 6617, maxCount = 1 },
	{ name = "blue gem", chance = 5379, maxCount = 1 },
	{ name = "weretiger trophy", chance = 7645, maxCount = 1 },
	{ name = "silver moon coin", chance = 10566, maxCount = 1 },
}


monster.attacks = {
	{ name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -400 },
	{ name ="combat", interval = 2000, chance = 18, type = COMBAT_EARTHDAMAGE, minDamage = -400, maxDamage = -500, radius = 2, effect = CONST_ME_GROUNDSHAKER, target = false },
	{ name ="combat", interval = 2000, chance = 14, type = COMBAT_HOLYDAMAGE, minDamage = -290, maxDamage = -360, length = 5, spread = 3, effect = CONST_ME_BLOCKHIT, target = false }
}

monster.defenses = {
	defense = 100,
	armor = 100
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
