local event = Event()
event.onStepTile = function(self, fromPosition, toPosition)
	return true
end

event:register()