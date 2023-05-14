local event = Event()

event.onMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if toPosition.x ~= CONTAINER_POSITION then
		return true
	end

	if item:getTopParent() == self and bit.band(toPosition.y, 0x40) == 0 then
		local itemType, moveItem = ItemType(item:getId())
		if bit.band(itemType:getSlotPosition(), SLOTP_TWO_HAND) ~= 0 and toPosition.y == CONST_SLOT_LEFT then
			moveItem = self:getSlotItem(CONST_SLOT_RIGHT)
		elseif itemType:getWeaponType() == WEAPON_SHIELD and toPosition.y == CONST_SLOT_RIGHT then
			moveItem = self:getSlotItem(CONST_SLOT_LEFT)
			if moveItem and bit.band(ItemType(moveItem:getId()):getSlotPosition(), SLOTP_TWO_HAND) == 0 then
				return true
			end
		end

		if moveItem then
			local parent = item:getParent()
			if parent:isContainer() and parent:getSize() == parent:getCapacity() then
				self:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM))
				return false
			else
				return moveItem:moveTo(parent)
			end
		end
	end
	
	if toPosition.x == CONTAINER_POSITION then
		local containerId = toPosition.y - 64
		local container = self:getContainerById(containerId)		
		if not container then
			return true 
		end

		-- Do not let the player insert items into either the Reward Container or the Reward Chest
		local itemId = container:getId()		
		if itemId == ITEM_REWARD_CONTAINER or itemId == ITEM_REWARD_CHEST then
			self:sendCancelMessage('Sorry, not possible.')
			return false
		end

		-- The player also shouldn't be able to insert items into the boss corpse		
		local tile = Tile(container:getPosition())
		for _, item in ipairs(tile:getItems()) do
			if item:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2^31 - 1 and item:getName() == container:getName() then
				self:sendCancelMessage('Sorry, not possible.')
				return false
			end
		end
	end

	-- Do not let the player move the boss corpse.
	if item:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2^31 - 1 then
		self:sendCancelMessage('Sorry, not possible.')
		return false
	end

	return true
end

event:register()
