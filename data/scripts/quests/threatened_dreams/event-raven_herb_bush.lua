local ThreatenedDreams = Storage.Quest.U11_40.ThreatenedDreams

local config = {
	-- createByType day / night
	[1] = { -- create in night
		herbId = 5953,
		herbWeight = 1,
		storage = ThreatenedDreams.Mission03.RavenHerbTimer
	}
}

local ravenHerb = Action()
function ravenHerb.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local herbConfig = config[1]
	local message = "You have found a " .. getItemName(herbConfig.herbId) .. "."
	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)

	if not backpack or backpack:getEmptySlots(true) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message .. " But you have no room to take it.")
		return true
	end
	if (player:getFreeCapacity() / 100) < herbConfig.herbWeight then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
		message .. ". Weighing " .. herbConfig.herbWeight .. " oz, it is too heavy for you to carry.")
		return true
	end

	if player:getStorageValue(herbConfig.storage) > os.time() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The raven herb cannot be collected right now.")
		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a " .. getItemName(herbConfig.herbId) .. ".")
	player:setStorageValue(herbConfig.storage, os.time() + 60 * 30 * 1000) -- Can be collected on next cycle
	player:addItem(herbConfig.herbId, 1)
	return true
end

ravenHerb:aid(ThreatenedDreams.Mission03.RavenHerbTimer)
ravenHerb:register()
