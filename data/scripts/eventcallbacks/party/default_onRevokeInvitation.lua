local event = Event()
event.onRevokeInvitation = function(self, player)
	player:say("test")
	
	
	return true
end

event:register()