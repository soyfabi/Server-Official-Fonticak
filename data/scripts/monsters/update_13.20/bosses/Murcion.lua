local mType = Game.createMonsterType("Murcion")
local monster = {}

monster.description = "Murcion"
monster.experience = 180000
monster.outfit = {
	lookType = 1664,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 350000
monster.maxHealth = 350000
monster.race = "undead"
monster.corpse = 44015
monster.speed = 500
monster.manaCost = 0

monster.changeTarget = {
	interval = 10000,
	chance = 20
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 98,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	ignoreSpawnBlock = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.events = {
}

monster.light = {
	level = 0,
	color = 0
}

monster.summon = {
}

monster.voices = {
}

monster.loot = {
	{ id = 3043, chance = 10000, maxCount = 6 }, 
	{ id = 16124, chance = 10000, maxCount = 15 },
	{ id = 7368, chance = 10000, maxCount = 100 }, 
	{ id = 6499, chance = 1000, maxCount = 2 }, 
	{ id = 7643, chance = 10000, maxCount = 10 }, 
	{ id = 238, chance = 10000, maxCount = 10 }, 
	{ id = 7642, chance = 10000, maxCount = 10 },
	{ id = 43855, chance = 3500 },
	{ id = 43501, chance = 10000, maxCount = 2 },
	{ id = 43854, chance = 18500, maxCount = 2 },
	{ id = 31990, chance = 15000, maxCount = 4 },
	{ id = 31965, chance = 15000, maxCount = 1 },
	{ id = 31966, chance = 10000, maxCount = 1 },
	{ id = 43853, chance = 28500, maxCount = 3 },
	{ id = 43853, chance = 8000, maxCount = 3 },
	{ id = 43855, chance = 3000 },
	{ id = 43854, chance = 6000, maxCount = 2 },
	{ id = 43965, chance = 500 },
	{ id = 43962, chance = 1500 },
	{ id = 44008, chance = 8000, maxCount = 2 },
	{ id = 3036, chance = 1000 },
	{ id = 23267, chance = 10000, maxCount = 5 },
	{ id = 32005, chance = 10000, maxCount = 3 },
	{ id = 32014, chance = 3000 },
	{ id = 23234, chance = 3000, maxCount = 2 },
	{ id = 23236, chance = 3000, maxCount = 3 },
	{ id = 23238, chance = 3000, maxCount = 3 },
	{ id = 3037, chance = 5000 }, 
	{ id = 32002, chance = 25000, maxCount = 2 },
	{ id = 3039, chance = 5000 }, 
	{ id = 3041, chance = 5000 }, 
	{ id = 3065, chance = 33000 }, 
	{ id = 3356, chance = 18000 }, 
	{ name = "living vine bow", chance = 3500 },
	{ name = "silkweaver bow", chance = 3000 },
	{ name = "thunder hammer", chance = 2000 },
	{ name = "gnome legs", chance = 1500 },
	{ name = "medal of valiance", chance = 2500 },


}

monster.attacks = {
	{ name ="melee", interval = 2000, chance = 100, minDamage = -1400, maxDamage = -2300 },
	{ name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -900, radius = 4, effect = CONST_ME_SMALLCLOUDS, target = false },
	{ name ="combat", interval = 2000, chance = 20, type = COMBAT_HOLYDAMAGE, minDamage = -500, maxDamage = -900, range = 4, radius = 4, shootEffect = 31, effect = 248, target = true },
	{ name ="combat", interval = 2000, chance = 20, type = COMBAT_ICEDAMAGE, minDamage = -1000, maxDamage = -1200, length = 10, spread = 3, effect = 53, target = false },
	{ name ="combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -1500, maxDamage = -1900, length = 10, spread = 3, effect = 158, target = false },
	{ name ="speed", interval = 2000, chance = 20, speedChange = -600, radius = 7, effect = CONST_ME_POFF, target = false, duration = 20000 }
}

monster.defenses = {
	defense = 105,
	armor = 105,
	{ name ="combat", interval = 3000, chance = 10, type = COMBAT_HEALING, minDamage = 800, maxDamage = 1500, effect = 236, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 15 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = 15 },
	{ type = COMBAT_FIREDAMAGE, percent = 15 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 15 },
	{ type = COMBAT_HOLYDAMAGE , percent = 15 },
	{ type = COMBAT_DEATHDAMAGE , percent = 15 }
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)