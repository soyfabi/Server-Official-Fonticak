local playerLogout = CreatureEvent("PlayerLogout")
function playerLogout.onLogout(player)
	local playerId = player:getId()
	if nextUseStaminaTime[playerId] then
		nextUseStaminaTime[playerId] = nil
	end
	return true
end
playerLogout:register()
