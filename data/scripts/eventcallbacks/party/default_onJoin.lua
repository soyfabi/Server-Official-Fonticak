local event = Event()
event.onGainSkillTries = function(self, skill, tries)

	
	
	return tries * configManager.getNumber(configKeys.RATE_SKILL)
end

event:register(1)