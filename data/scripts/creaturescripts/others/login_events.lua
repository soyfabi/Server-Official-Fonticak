local loginEvents = CreatureEvent("LoginEvents")
function loginEvents.onLogin(player)
	local events = {
	--"killer",
	}
	
	for i = 1, #events do
		player:registerEvent(events[i])
	end
	
	return true
end
loginEvents:register()
