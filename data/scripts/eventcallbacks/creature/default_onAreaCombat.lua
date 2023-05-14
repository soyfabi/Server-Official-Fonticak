local event = Event()
function event.onAreaCombat(tile, isAggressive)
	return true
end

event:register()
