local event = Event()
event.onChangeGhostMode = function(self)
	return true
end
event:register()