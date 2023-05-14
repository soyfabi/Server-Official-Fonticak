-- Not Pushed in PZ --
local event = Event()
event.onMoveCreature = function(self, creature, fromPosition, toPosition)

	if creature:getTile():hasFlag(TILESTATE_PROTECTIONZONE) then --/ PROTECTION ZONE TILE
		self:sendCancelMessage("You can not pushed in protection zone.")
        return false
    end
	
	self:sendCancelMessage("You just pushed a "..creature:getName()..".")
	
	return true
end

event:register()
