local mType = Game.createMonsterType("Magma Bubble")
local monster = {}
monster.description = "magma bubble"
monster.experience = 80000
monster.outfit = {
	lookType = 1413,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.events = {
	--"MagmaBubbleDeath"
}

monster.health = 300000
monster.maxHealth = 300000
monster.race = "undead"
monster.corpse = 36843
monster.speed = 40
monster.corpse = 36847
monster.speed = 0
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.flags = {
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.loot = {
	{ name = "giant emerald", chance = 4082 },
	{ name = "giant sapphire", chance = 2041 },
	{ name = "giant topaz", chance = 2041 },
	{ name = "fiery tear", chance = 1000 },
	{ name = "arboreal tome", chance = 250 },
	{ name = "arboreal crown", chance = 250 },
	{ name = "spiritthorn armor", id = 39147, chance = 250 },
	{ id = 39186, chance = 250 }, -- name = "charged arboreal ring"
	{ id = 39180, chance = 250 }, -- name = "charged alicorn ring"
	{ id = 39177, chance = 250 }, -- name = "charged spiritthorn ring"
	{ name = "portable flame", chance = 250 },
	{ name = "firefighting axe", chance = 250 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -600, maxDamage = -1300 },
	{ name = "combat", interval = 200, chance = 20, type = COMBAT_ENERGYDAMAGE, minDamage = -600, maxDamage = -1500, target = false },
	{ name = "combat", interval = 500, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -2100, length = 8, spread = 3, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 500, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -250, maxDamage = -2600, radius = 8, effect = CONST_ME_MORTAREA, target = false },
	{ name = "combat", interval = 2000, chance = 30, type = COMBAT_FIREDAMAGE, minDamage = -1000, maxDamage = -2000, target = true },
	{ name = "combat", interval = 2000, chance = 25, type = COMBAT_FIREDAMAGE, minDamage = -1500, maxDamage = -2000, length = 8, spread = 0, effect = CONST_ME_FIREAREA, target = false },
	{ name = "melee", interval = 2000, chance = 100, minDamage = -275, maxDamage = -750 },
	{ name = "combat", interval = 2000, chance = 75, type = COMBAT_FIREDAMAGE, minDamage = -525, maxDamage = -650, radius = 3, range = 8, effect = CONST_ME_HITBYFIRE, target = true },
	{ name = "combat", interval = 3700, chance = 37, type = COMBAT_FIREDAMAGE, minDamage = -1700, maxDamage = -2750, length = 8, spread = 3, effect = CONST_ME_MAGIC_RED, target = false },
	{ name = "combat", interval = 3100, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -1000, maxDamage = -2000, range = 8, effect = CONST_ME_FIREAREA, shootEffect = CONST_ANI_FIRE, target = true },
}

monster.defenses = {
	defense = 65,
	armor = 55,
	{ name = "combat", interval = 3000, chance = 35, type = COMBAT_HEALING, minDamage = 400, maxDamage = 500, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 }
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 100 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 }
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