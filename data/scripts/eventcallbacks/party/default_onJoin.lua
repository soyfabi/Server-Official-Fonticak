local event = Event()
event.onJoin = function(self, skill, tries)

	
	
	return tries * configManager.getNumber(configKeys.RATE_SKILL)
end

--event:register(1)