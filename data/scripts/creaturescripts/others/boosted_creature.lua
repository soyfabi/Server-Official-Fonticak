if not boostCreature then boostCreature = {} end

local BoostedCreature = {
    monsters_exp = {"Hydra", "Frost Dragon", "Werehyaena", "Dragon Lord"},
    monsters_loot = {"Rotworm"},
    monsters_boss = {"Scarlet Etzel"},
    db = true,
    exp = {20, 45},
    loot = {20, 45},
	exp_boss = {15, 30},
	loot_boss = {7, 12},
    messages = {
        prefix = "[Boosted Creature] ",
        chosen = "The creature chosen was %s. When killing you receive +%d of experience and +%d of loot.",
    },
}

function capitalizeFirstLetter(str)
    return str:gsub("^%l", string.upper)
end

function BoostedCreature:start()
    local rand = math.random
    local monsterRand_exp = BoostedCreature.monsters_exp[rand(#BoostedCreature.monsters_exp)]
    local monsterRand_loot = BoostedCreature.monsters_loot[rand(#BoostedCreature.monsters_loot)]
    local monsterRand_boss = BoostedCreature.monsters_boss[rand(#BoostedCreature.monsters_boss)]
    local expRand = rand(BoostedCreature.exp[1], BoostedCreature.exp[2])
    local lootRand = rand(BoostedCreature.loot[1], BoostedCreature.loot[2])
	local expRand_boss = rand(BoostedCreature.exp_boss[1], BoostedCreature.exp_boss[2])
	local lootRand_boss = rand(BoostedCreature.loot_boss[1], BoostedCreature.loot_boss[2])
	local boost_exp = {name = capitalizeFirstLetter(monsterRand_exp), exp = expRand, loot = lootRand}
    local boost_loot = {name_loot = capitalizeFirstLetter(monsterRand_loot), loot = lootRand}
    local boost_boss = {name_boss = capitalizeFirstLetter(monsterRand_boss), exp_boss = expRand_boss, loot_boss = lootRand_boss}
    boostCreature = {}
    table.insert(boostCreature, boost_exp)
    table.insert(boostCreature, boost_loot)
    table.insert(boostCreature, boost_boss)
end

BoostedCreature:start()

local boostedlogin = CreatureEvent("Boosted_Login")
function boostedlogin.onLogin(player)
    addEvent(function()
        local message = "Every day the list of bonus monsters is always updated, these are today's.\nToday daily creatures are:\n[" .. boostCreature[1].name .. "]\nBonus Exp Rate: " .. boostCreature[1].exp .. "%.\n[".. boostCreature[2].name_loot.."]\nExtra Loot Rate: " .. boostCreature[2].loot .. "%."
        if boostCreature[3] and boostCreature[3].name_boss then
            message = message .. "\n[".. boostCreature[3].name_boss .. "]\nSpecial Loot Rate: ".. boostCreature[3].loot_boss .. "%."
        else
            message = message .. "\nNo boss today."
        end
        player:sendTextMessage(MESSAGE_INFO_DESCR, message)
    end, 2000)
    return true
end

boostedlogin:register()

-- EventCallBack / onGainExperience --

local ec = Event()

function ec.onGainExperience(self, source, exp, rawExp)
    -- Boost Creature
	if not source or source:isPlayer() then
		return exp
	end
	
    local extraXp = 0
    if (source:getName():lower() == capitalizeFirstLetter(boostCreature[1].name):lower()) then
        local extraPercent = boostCreature[1].exp
        extraXp = exp * extraPercent / 100
        addEvent(function() Game.sendAnimatedText("+" .. extraXp .. " exp", self:getPosition(), 102) end, 250)
    end
	
	local extraXp_boss = 0
    if (source:getName():lower() == capitalizeFirstLetter(boostCreature[3].name_boss):lower()) then
        local extraPercent = boostCreature[3].exp_boss
        extraXp_boss = exp * extraPercent / 100
        addEvent(function() Game.sendAnimatedText("+" .. extraXp_boss .. " exp", self:getPosition(), 102) end, 250)
    end

    return exp + extraXp + extraXp_boss
end

ec:register()

------- TALKACTION -------
local boostedmtalk = TalkAction("!boosted","!boostedcreature")

local exhaust = {}
local exhaustTime = 2

function boostedmtalk.onSay(player, words, param)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This command is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
	local message = "[Boosted Creature]\nEvery day 3 monsters will be chosen, exp, loot and a boss.\nCreature of Today:\n\nMonster Exp: ".. firstToUpper(boostCreature[1].name) ..".\n[+] Bonus Experience: +".. boostCreature[1].exp .."%.\n\nMonster Loot: "..firstToUpper(boostCreature[2].name_loot)..".\n[+] Bonus Loot: +".. boostCreature[1].loot .."%.\n\nMonster Boss: ".. firstToUpper(boostCreature[3].name_boss) ..".\n[+] Bonus Exp: ".. boostCreature[3].exp_boss .."%.\n[+] Special Bonus Loot: ".. boostCreature[3].loot_boss .."%.\n\nThese have been the monsters of the day, check back tomorrow."
	player:popupFYI(message)
	exhaust[playerId] = currentTime + exhaustTime
	return false
end

boostedmtalk:register()