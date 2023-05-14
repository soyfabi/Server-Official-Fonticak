local event = Event()
event.onTurn = function(self, direction)

	if self:getGroup():getAccess() and self:getDirection() == direction then
        local nextPosition = self:getPosition()
        nextPosition:getNextPosition(direction)
        self:teleportTo(nextPosition, true)
		self:getPosition(): sendMagicEffect(CONST_ME_TELEPORT)
    end
	
	--[[if not self:getGroup():getAccess() then
        if self:getStorageValue(94742) >= os.time() then
            return false
        else
            self:setStorageValue(94742, os.time() + 1)
        end
    end]]
	
	return true
end

event:register()
