local mType = Game.createMonsterType("Grand Master Oberon")
local monster = {}

monster.description = "Grand Master Oberon"
monster.experience = 20000
monster.outfit = {
	lookType = 1072,
	lookHead = 21,
	lookBody = 96,
	lookLegs = 21,
	lookFeet = 105,
	lookAddons = 1,
	lookMount = 0
}

monster.health = 30000
monster.maxHealth = 30000
monster.race = "blood"
monster.corpse = 28625
monster.speed = 115
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
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
	{id = 3115, chance = 30000, maxCount = 1}, -- bone
	{name = "brass shield", chance = 30000, maxCount = 1},
	{name = "spatial warp almanac", chance = 25000, maxCount = 1},
	{name = "viking helmet", chance = 23000, maxCount = 1},
	{name = "falcon battleaxe", chance = 500, maxCount = 1},
	{name = "falcon longsword", chance = 500, maxCount = 1},
	{name = "falcon mace", chance = 500, maxCount = 1},
	{name = "grant of arms", chance = 500, maxCount = 1},
	{name = "falcon bow", chance = 350, maxCount = 1},
	{name = "falcon circlet", chance = 350, maxCount = 1},
	{name = "falcon coif", chance = 350, maxCount = 1},
	{name = "falcon rod", chance = 350, maxCount = 1},
	{name = "falcon wand", chance = 350, maxCount = 1},
	{name = "falcon shield", chance = 200, maxCount = 1},
	{name = "falcon greaves", chance = 200, maxCount = 1},
	{name = "falcon plate", chance = 200, maxCount = 1},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1200},
	{name ="combat", interval = 6000, chance = 80, type = COMBAT_HOLYDAMAGE, minDamage = -1000, maxDamage = -2250, length = 8, spread = 3, effect = CONST_ME_HOLYAREA, target = false},
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -820, maxDamage = -1450, radius = 5, effect = CONST_ME_HITAREA, target = false},
	{name ="combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -860, maxDamage = -1500, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false}
}

monster.defenses = {
	defense = 60,
	armor = 82,
	{name ="speed", interval = 1000, chance = 10, speedChange = 180, effect = CONST_ME_POFF, target = false, duration = 4000}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = -5},
	{type = COMBAT_EARTHDAMAGE, percent = 5},
	{type = COMBAT_FIREDAMAGE, percent = -5},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = -25},
	{type = COMBAT_DEATHDAMAGE , percent = 100}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = true},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
	if monster:getStorageValue(GrandMasterOberonConfig.Storage.Life) <= GrandMasterOberonConfig.AmountLife then
		local percentageHealth = (monster:getHealth()*100)/monster:getMaxHealth()
		if percentageHealth <= 20 then
			SendOberonAsking(monster)
		end
	end
end

mType.onAppear = function(monster, creature)
	if monster:getId() == creature:getId() then
		monster:setStorageValue(GrandMasterOberonConfig.Storage.Asking, 1)
		monster:setStorageValue(GrandMasterOberonConfig.Storage.Life, 1)
	end
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
	local exhaust = GrandMasterOberonConfig.Storage.Exhaust
	if creature:isPlayer() and monster:getStorageValue(exhaust) <= os.time() then
		message = message:lower()

		monster:setStorageValue(exhaust, os.time() + 1)
		local asking_storage = monster:getStorageValue(GrandMasterOberonConfig.Storage.Asking)
		local oberonMessagesTable = GrandMasterOberonResponses[asking_storage];

		if oberonMessagesTable then
			if message == oberonMessagesTable.msg:lower() or message == oberonMessagesTable.msg2:lower() then
				monster:say("GRRRAAANNGH!", TALKTYPE_MONSTER_SAY)
				monster:unregisterEvent('OberonImmunity')
			else
				monster:say("HAHAHAHA!", TALKTYPE_MONSTER_SAY)
			end
		end
	end
end

mType:register(monster)

local oberonOthersMessages = {
	[1] = "Are you ever going to fight or do you prefer talking! Then let me show you the concept of mortality before it! Dare strike up a Minnesang and you will receive your last accolade!",
	[2] = "Even before they smell your breath? Too bad you barely exist at all! SEHWO ASIMO, TOLIDO ESD Excuse me but I still do not get the message! Then why are we fighting alone right now? How appropriate, you look like something worms already got the better of!",
};

GrandMasterOberonAsking = {
	[1] = {msg = "You appear like a worm among men!"},
	[2] = {msg = "The world will suffer for its iddle laziness!"},
	[3] = {msg = "People fall at my feet when they see me coming!"},
	[4] = {msg = "This will be the end of mortal man!"},
	[5] = {msg = "I will remove you from this plane of existence!"},
	[6] = {msg = "Dragons will soon rule this world, I am their herald!"},
	[7] = {msg = "The true virtue of chivalry are my belief!"},
	[8] = {msg = "I lead the most honourable and formidable following of knights!"},
	[9] = {msg = "ULTAH SALID'AR, ESDO LO!"},
}

GrandMasterOberonResponses = {
	[1] = {msg = "How appropriate, you look like something worms already got the better of!", msg2 = oberonOthersMessages[2]},
	[2] = {msg = "Are you ever going to fight or do you prefer talking!", msg2 = oberonOthersMessages[1]},
	[3] = {msg = "Even before they smell your breath?", msg2 = oberonOthersMessages[2]},
	[4] = {msg = "Then let me show you the concept of mortality before it!", msg2 = oberonOthersMessages[1]},
	[5] = {msg = "Too bad you barely exist at all!", msg2 = oberonOthersMessages[2]},
	[6] = {msg = "Excuse me but I still do not get the message!", msg2 = oberonOthersMessages[2]},
	[7] = {msg = "Dare strike up a Minnesang and you will receive your last accolade!", msg2 = oberonOthersMessages[1]},
	[8] = {msg = "Then why are we fighting alone right now?", msg2 = oberonOthersMessages[2]},
	[9] = {msg = "SEHWO ASIMO, TOLIDO ESD!", msg2 = oberonOthersMessages[2]},
}

GrandMasterOberonConfig = {
	Storage = {
		Asking = 1,
		Life = 2,
		Exhaust = 3,
	},
	Monster = {
		"Falcon Knight",
		"Falcon Paladin"
	},
	AmountLife = 3
}

local function healOberon(monster)
	local storage = monster:getStorageValue(GrandMasterOberonConfig.Storage.Life)
	monster:setStorageValue(GrandMasterOberonConfig.Storage.Life, storage + 1)
	monster:addHealth(monster:getMaxHealth())

end

function SendOberonAsking(monster)
	monster:registerEvent('OberonImmunity')
	local random = math.random(#GrandMasterOberonAsking)
	monster:say(GrandMasterOberonAsking[random].msg, TALKTYPE_MONSTER_SAY)
	monster:setStorageValue(GrandMasterOberonConfig.Storage.Asking, random)

	healOberon(monster)

	Game.createMonster(GrandMasterOberonConfig.Monster[math.random(#GrandMasterOberonConfig.Monster)], monster:getPosition(), true, true)
end
