local event = Event()
event.onLeave = function(self, player)
	player:say("test")
	
	
	return true
end

event:register()