local increasing = {[419] = 420, [431] = 430, [452] = 453, [563] = 564, [549] = 562, [10145] = 10146}
local decreasing = {[420] = 419, [430] = 431, [453] = 452, [564] = 563, [562] = 549, [10146] = 10145}

-- onStepIn
local tiles = MoveEvent()

function tiles.onStepIn(creature, item, position, fromPosition)
	if not increasing[item.itemid] then
		return true
	end

	local player = creature:getPlayer()
	if not player or player:isInGhostMode() then
		return true
	end

	item:transform(increasing[item.itemid])

	if item.actionid >= 1000 then
		if player:getLevel() < item.actionid - 1000 then
			player:teleportTo(fromPosition, false)
			position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "The tile seems to be protected against unwanted intruders.")
		end
		return true
	end

	if Tile(position):hasFlag(TILESTATE_PROTECTIONZONE) then
		local lookPosition = creature:getPosition()
		lookPosition:getNextPosition(creature:getDirection())
		local depotItem = Tile(lookPosition):getItemByType(ITEM_TYPE_DEPOT)
		local rewards = #player:getRewardList()
		if depotItem then
			local depotItems = creature:getDepotChest(getDepotId(depotItem:getUniqueId()), true):getItemHoldingCount()
			local inboxItems = creature:getInbox():getItemHoldingCount()
			local supplystashItems = creature:getSupplyStash():getItemHoldingCount()
			creature:sendCancelMessage("Your Depot contains ".. depotItems .." item" .. (depotItems > 1 and "s," or ",") .." the Supply Stash contains ".. supplystashItems .." item".. (supplystashItems > 1 and "s" or ",") .." the Reward Chest contains ".. rewards .." bag".. (rewards > 1 and "s" or "") .." and the Inbox contains ".. inboxItems .." item".. (inboxItems > 1 and "s." or "."))
			return true
		end
	end

	if item.actionid ~= 0 and player:getStorageValue(item.actionid) <= 0 then
		player:teleportTo(fromPosition, false)
		position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The tile seems to be protected against unwanted intruders.")
		return true
	end
end

tiles:type("stepin")

for index, value in pairs(increasing) do
	tiles:id(index)
end

tiles:register()

tiles = MoveEvent()

function tiles.onStepOut(creature, item, position, fromPosition)
	if not decreasing[item.itemid] then
		return false
	end

	local player = creature:getPlayer()
	if not player or player:isInGhostMode() then
		return true
	end

	item:transform(decreasing[item.itemid])
	return true
end

tiles:type("stepout")

for index, value in pairs(decreasing) do
	tiles:id(index)
end

tiles:register()
