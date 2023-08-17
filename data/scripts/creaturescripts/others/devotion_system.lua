local devotion_kill = CreatureEvent("devotion_kill")

local bossPoints = {
    ["Dog"] = 10,
    ["Cat"] = 20,
}

function devotion_kill.onKill(player, target)
	if target:isPlayer() or target:getMaster() then
        return true
    end
	
	local targetName = target:getName()
	
	local devotion = bossPoints[targetName]
	
	if devotion then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "For killing the Boss " .. targetName .. " you were awarded " .. devotion .. " Devotion Points.")
        player:addDevotion(devotion)
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

local skill = {MagicLevel = 200, Fist = 200, Club = 200, Sword = 200, Axe = 200, Distance = 200, HealthMax = 200, ManaMax = 200}

function talk.onSay(player, words, param)
	local text = "[Devotion System]\nPoints are stored as you kill bosses.\n\nYou have:\n[+] "..player:getDevotion().." Devotion Points.\n---------->\nRemember that you can use these points to get an\nextra skill or increase life or mana.\n\nMagic Level:                                 Sword Fighting:\n[+] "..skill.MagicLevel.." Devotion Points.          [+] "..skill.Sword.." Devotion Points.\n\nFist Fighting:                                Axe Fighting:\n[+] "..skill.Fist.." Devotion Points.          [+] "..skill.Axe.." Devotion Points.\n\nClub Fighting:                               Distance Fighting:\n[+] "..skill.Club.." Devotion Points.          [+] "..skill.Distance.." Devotion Points.\n---------->\nKeep in mind that you only add 1 to the skill, if you\nchoose Magic Level then +1 will be added to both the\nother skills.\n\nExtra attributes:\nHealth Max:                                  Mana Max:\n[+] "..skill.HealthMax.." Devotion Points.          [+] "..skill.ManaMax.." Devotion Points.\n---------->\nFor health you would add 10 life points for both\n10 mana points.\n\nTo use the points, just say !devotion [skillname]\nEx: !devotion magic level."
	player:popupFYI(text)
	return false
end

talk:register()
