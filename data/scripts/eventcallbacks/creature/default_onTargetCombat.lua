local event = Event()
function event.onTargetCombat(self, target)
	if not self then
		return true
	end
	
	self:addEventStamina(target)
	return true
end

event:register()


