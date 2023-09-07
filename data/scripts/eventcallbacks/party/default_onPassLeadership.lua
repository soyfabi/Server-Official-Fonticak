local event = Event()
event.onPassLeadership = function(self, player)
	player:say("test")
	
	
	return true
end

event:register()