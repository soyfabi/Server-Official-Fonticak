local Monster_Name = "Scarab"

local event = CreatureEvent("Kill_Scarab")

function event.onKill(creature, target)
	if target:isPlayer() or target:getMaster()  or target:getName():lower() ~= Monster_Name:lower() then
        return true
    end
	
	if math.random(100) < 10 then
		addEvent(function()Game.createMonster("Scorpion", target:getPosition()) end, 100)
		target:say("Horestis' curse spawns a vengeful scorpion from the body!")
	end
	
    return true
end

event:register()

local login = CreatureEvent("Register_Scarab")

function login.onLogin(player)
    player:registerEvent("Kill_Scarab")
    return true
end

login:register()
