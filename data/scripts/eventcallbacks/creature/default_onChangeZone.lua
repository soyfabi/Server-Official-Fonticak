local event = Event()
function event.onChangeZone(self, fromZone, toZone)
	if toZone == ZONE_PROTECTION then
		self:say("I'm protected!")
	end
end

event:register()
