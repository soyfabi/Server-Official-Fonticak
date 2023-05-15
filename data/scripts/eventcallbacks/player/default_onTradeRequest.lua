local event = Event()

local exercise_ids = {
	28540,
	28552,
	35279,
	35285,
	28553,	
	28541,
	35280,
	35286,
	28554,
	28542,
	35281,
	35287,
	28544,
	28556,
	35283,
	35289,
	28543,
	28555,
	35282,
	35288,
	28545,
	28557,
	35284,
	35290,
}

event.onTradeRequest = function(self, target, item)

	if isInArray(exercise_ids,item.itemid) then
		self:sendCancelMessage('You cannot trade this item.')
        return false
    end
	
	return true
end

event:register()
