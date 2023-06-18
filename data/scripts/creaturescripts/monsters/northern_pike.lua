local Monster_Name = "Northern Pike"

local event = CreatureEvent("Fish_North")

function event.onKill(creature, target)
	if target:isPlayer() or target:getMaster() or target:getName():lower() ~= Monster_Name:lower() then
        return true
    end
	
	local chance = math.random(1, 100)
	if chance < 25 then
		addEvent(function()Game.createMonster("Slippery Northern Pike", target:getPosition()) end, 100)
		target:say("Slap-SLAP")
	end
	
    return true
end

event:register()

local login = CreatureEvent("Register_Fish_North")

function login.onLogin(player)
    player:registerEvent("Fish_North")
    return true
end

login:register()


