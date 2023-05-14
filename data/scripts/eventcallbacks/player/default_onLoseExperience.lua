local event = Event()
event.onLoseExperience = function(self, exp)
	return exp
end

event:register()