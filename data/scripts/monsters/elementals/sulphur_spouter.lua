local mType = Game.createMonsterType("Sulphur Spouter")
local monster = {}

monster.description = "a Sulphur Spouter"
monster.experience = 11517
monster.outfit = {
	lookType = 1547,
	lookHead = 85,
	lookBody = 1,
	lookLegs = 85,
	lookFeet = 105,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 19000
monster.maxHealth = 19000
monster.race = "blood"
monster.corpse = 39279
monster.speed = 182
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
	{text = "Gruugl...", yell = false},
}

monster.loot = {
	{name = "Sulphur Powder", chance = 39440},
	{name = "Crystal Coin", chance = 22310, maxCount = 2},
	{name = "Ultimate Mana Potion", chance = 12890, maxCount = 2},
	{name = "Yellow Gem", chance = 2820},
	{id = 282, chance = 2450}, -- Giant Shimmering Pearl (Green)
	{name = "Slightly Rusted Legs", chance = 2420},
	{name = "Knight Legs", chance = 2360},
	{id = 3039, chance = 2190}, -- Red Gem
	{name = "Warrior's Shield", chance = 1760},
	{id = 23533, chance = 1110}, -- Ring of Red Plasma
	{name = "Fire Sword", chance = 770},
	{name = "Crystal Crossbow", chance = 510},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -300, maxDamage = -801},
	{name ="combat", interval = 3000, chance = 47, type = COMBAT_PHYSICALDAMAGE, minDamage = -800, maxDamage = -1500, range = 4, shootEffect = CONST_ANI_HOLY, effect = CONST_ME_YELLOW_RINGS, target = true},
	{name ="combat", interval = 1000, chance = 31, type = COMBAT_LIFEDRAIN, minDamage = -800, maxDamage = -1500, radius = 4, effect = CONST_ME_YELLOWSMOKE, target = true},
}

monster.defenses = {
	defense = 110,
	armor = 84,
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
	{type = COMBAT_HOLYDAMAGE , percent = -20},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)