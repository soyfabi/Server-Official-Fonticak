local event = Event()
event.onDisband = function(self, player)
	player:say("test")
	
	
	return true
end

event:register()