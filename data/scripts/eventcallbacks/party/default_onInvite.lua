local event = Event()
event.onInvite = function(self, player)
	player:say("test")
	
	
	return true
end

event:register()