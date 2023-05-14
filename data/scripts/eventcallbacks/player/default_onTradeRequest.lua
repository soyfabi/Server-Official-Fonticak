local event = Event()
event.onTradeRequest = function(self, target, item)
	return true
end

event:register()
