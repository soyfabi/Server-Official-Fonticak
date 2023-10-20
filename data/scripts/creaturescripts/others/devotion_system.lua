local devotion_kill = CreatureEvent("devotion_kill")

local bossPoints = {
    ["Scarlett Etzel"] = 10,
    ["Grand Master Oberon"] = 20,
}

function devotion_kill.onKill(player, target)
	if target:isPlayer() or target:getMaster() then
        return true
    end
	
	local targetName = target:getName()
	local devotion = bossPoints[targetName]
	
	local damageMap = target:getDamageMap()
	for key, value in pairs(damageMap) do
		local attackerPlayer = Player(key)
		if attackerPlayer then
			if devotion then
				attackerPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "For killing the Boss " .. targetName .. " you were awarded " .. devotion .. " Devotion Points.")
				attackerPlayer:addDevotion(devotion)
			end
		end
	end
	
	return true
end

devotion_kill:register()

local devotionLogin = CreatureEvent("devotionLogin")
function devotionLogin.onLogin(player)
	player:registerEvent("devotion_kill")
	return true
end

devotionLogin:register()

local talk = TalkAction("!devotion")

local exhaust = {}
local exhaustTime = 2

local skill = {MagicLevel = 700, Fist = 200, Club = 500, Sword = 500, Axe = 500, Distance = 600, HealthMax = 1200, ManaMax = 1200}

function talk.onSay(player, words, param)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return false
	end

	if param == "magic level" then
		local skillCost = skill.MagicLevel
		if player:getDevotion() >= skillCost then
			player:addDevotion(-skillCost)
			player:popupFYI("[Devotion System]\nYou just added +1 Magic Level per "..skillCost.." Devotion Points.\n\nNow you have:\n[+] "..player:getDevotion().." Devotion Points.")
			player:addMagicLevel(1)
			return false
		else
			player:popupFYI("[Devotion System]\nYou don't have enough devotion points.")
			exhaust[playerId] = currentTime + exhaustTime
			return false
		end
	elseif param == "fist" or param == "fist fighting" then
		local skillCost = skill.Fist
		if player:getDevotion() >= skillCost then
			player:addDevotion(-skillCost)
			player:popupFYI("[Devotion System]\nYou just added +1 Fist Fighting per "..skillCost.." Devotion Points.\n\nNow you have:\n[+] "..player:getDevotion().." Devotion Points.")
			player:addSkillTries(SKILL_FIST, player:getVocation():getRequiredSkillTries(SKILL_FIST, player:getSkillLevel(SKILL_FIST) + 1) - player:getSkillTries(SKILL_FIST), true)
			return false
		else
			player:popupFYI("[Devotion System]\nYou don't have enough devotion points.")
			exhaust[playerId] = currentTime + exhaustTime
			return false
		end
	elseif param == "club" or param == "club fighting" then
		local skillCost = skill.Club
		if player:getDevotion() >= skillCost then
			player:addDevotion(-skillCost)
			player:popupFYI("[Devotion System]\nYou just added +1 Club Fighting per "..skillCost.." Devotion Points.\n\nNow you have:\n[+] "..player:getDevotion().." Devotion Points.")
			player:addSkillTries(SKILL_CLUB, player:getVocation():getRequiredSkillTries(SKILL_CLUB, player:getSkillLevel(SKILL_CLUB) + 1) - player:getSkillTries(SKILL_CLUB), true)
			return false
		else
			player:popupFYI("[Devotion System]\nYou don't have enough devotion points.")
			exhaust[playerId] = currentTime + exhaustTime
			return false
		end
	elseif param == "sword" or param == "sword fighting" then
		local skillCost = skill.Sword
		if player:getDevotion() >= skillCost then
			player:addDevotion(-skillCost)
			player:popupFYI("[Devotion System]\nYou just added +1 Sword Fighting per "..skillCost.." Devotion Points.\n\nNow you have:\n[+] "..player:getDevotion().." Devotion Points.")
			player:addSkillTries(SKILL_SWORD, player:getVocation():getRequiredSkillTries(SKILL_SWORD, player:getSkillLevel(SKILL_SWORD) + 1) - player:getSkillTries(SKILL_SWORD), true)
			return false
		else
			player:popupFYI("[Devotion System]\nYou don't have enough devotion points.")
			exhaust[playerId] = currentTime + exhaustTime
			return false
		end
	elseif param == "axe" or param == "axe fighting" then
		local skillCost = skill.Axe
		if player:getDevotion() >= skillCost then
			player:addDevotion(-skillCost)
			player:popupFYI("[Devotion System]\nYou just added +1 Axe Fighting per "..skillCost.." Devotion Points.\n\nNow you have:\n[+] "..player:getDevotion().." Devotion Points.")
			player:addSkillTries(SKILL_AXE, player:getVocation():getRequiredSkillTries(SKILL_AXE, player:getSkillLevel(SKILL_AXE) + 1) - player:getSkillTries(SKILL_AXE), true)
			return false
		else
			player:popupFYI("[Devotion System]\nYou don't have enough devotion points.")
			exhaust[playerId] = currentTime + exhaustTime
			return false
		end
	elseif param == "distance" or param == "distance fighting" then
		local skillCost = skill.Distance
		if player:getDevotion() >= skillCost then
			player:addDevotion(-skillCost)
			player:popupFYI("[Devotion System]\nYou just added +1 Distance Fighting per "..skillCost.." Devotion Points.\n\nNow you have:\n[+] "..player:getDevotion().." Devotion Points.")
			player:addSkillTries(SKILL_DISTANCE, player:getVocation():getRequiredSkillTries(SKILL_DISTANCE, player:getSkillLevel(SKILL_DISTANCE) + 1) - player:getSkillTries(SKILL_DISTANCE), true)
			return false
		else
			player:popupFYI("[Devotion System]\nYou don't have enough devotion points.")
			exhaust[playerId] = currentTime + exhaustTime
			return false
		end
	elseif param == "health" or param == "health max" then
		local skillCost = skill.HealthMax
		if player:getDevotion() >= skillCost then
			player:addDevotion(-skillCost)
			player:popupFYI("[Devotion System]\nYou just added +10 Health Max per "..skillCost.." Devotion Points.\n\nNow you have:\n[+] "..player:getDevotion().." Devotion Points.")
			player:setMaxHealth(player:getMaxHealth() + 10)
			return false
		else
			player:popupFYI("[Devotion System]\nYou don't have enough devotion points.")
			exhaust[playerId] = currentTime + exhaustTime
			return false
		end
	elseif param == "mana" or param == "mana max" then
		local skillCost = skill.ManaMax
		if player:getDevotion() >= skillCost then
			player:addDevotion(-skillCost)
			player:popupFYI("[Devotion System]\nYou just added +10 Mana Max per "..skillCost.." Devotion Points.\n\nNow you have:\n[+] "..player:getDevotion().." Devotion Points.")
			player:setMaxMana(player:getMaxMana() + 10)
			return false
		else
			player:popupFYI("[Devotion System]\nYou don't have enough devotion points.")
			exhaust[playerId] = currentTime + exhaustTime
			return false
		end
		return false
	end
	
	local text = "[Devotion System]\nPoints are stored as you kill bosses.\n\nYou have:\n[+] "..player:getDevotion().." Devotion Points.\n---------->\nRemember that you can use these points to get an\nextra skill or increase life or mana.\n\nMagic Level:                                 Sword Fighting:\n[+] "..skill.MagicLevel.." Devotion Points.          [+] "..skill.Sword.." Devotion Points.\n\nFist Fighting:                                Axe Fighting:\n[+] "..skill.Fist.." Devotion Points.          [+] "..skill.Axe.." Devotion Points.\n\nClub Fighting:                               Distance Fighting:\n[+] "..skill.Club.." Devotion Points.          [+] "..skill.Distance.." Devotion Points.\n---------->\nKeep in mind that you only add 1 to the skill, if you\nchoose Magic Level then +1 will be added to both the\nother skills.\n\nExtra attributes:\nHealth Max:                                  Mana Max:\n[+] "..skill.HealthMax.." Devotion Points.          [+] "..skill.ManaMax.." Devotion Points.\n---------->\nFor health you would add 10 life points for both\n10 mana points.\n\nTo use the points, just say !devotion [skillname]\nEx: !devotion magic level."
	player:popupFYI(text)
	exhaust[playerId] = currentTime + exhaustTime
	return false
end

talk:separator(" ")
talk:register()
