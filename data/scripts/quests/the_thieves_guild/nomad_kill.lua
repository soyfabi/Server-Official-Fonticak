local nomadKill = CreatureEvent("NomadKill")
local nomadkill = "Nomad"
function nomadKill.onKill(creature, target)
	if target:isPlayer() or target:getMaster()  or target:getName():lower() ~= nomadkill:lower() then
        return true
    end

	local player = creature:getPlayer()
	if player:getStorageValue(Storage.ThievesGuild.Mission04) == 3 then
		player:setStorageValue(Storage.ThievesGuild.Mission04, 4)
	end

	return true
end

nomadKill:register()

local nomadLogin = CreatureEvent("nomadLogin")
function nomadLogin.onLogin(player)
	player:registerEvent("NomadKill")
	return true
end

nomadLogin:register()
