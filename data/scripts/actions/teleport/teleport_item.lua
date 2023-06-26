local config = {
	[29954] = { -- Faceless Bane entrance
		item_pos = Position(33619, 32518, 15),
		teleport_pos = Position(33639, 32560, 13),
		text = "All chants have been sung in the night order, you are deemed worthy. You are transported away...", 
		direction = DIRECTION_EAST,
	},
	[5679] = { -- Exotic Cave Entrance
		item_pos = Position(33918, 31471, 7),
		teleport_pos = Position(33916, 31465, 8),
		direction = DIRECTION_NORTH,
	},
}

local teleport_item = Action()

function teleport_item.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local teleport_item = config[item:getId()]
	if not teleport_item or not player then
		return false
	end
		
	if teleport_item then
		if teleport_item.item_pos == item:getPosition() then
		local playerPos = player:getPosition()
		player:teleportTo(teleport_item.teleport_pos)
		playerPos:sendMagicEffect(CONST_ME_TELEPORT)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:setDirection(teleport_item.direction)
		end
	end
	
	if teleport_item.item_pos == item:getPosition() and teleport_item.text then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, teleport_item.text)
	end
	
	return true
end

for index, value in pairs(config) do
	teleport_item:id(index)
end
teleport_item:register()

local configAction = {
	[29900] = { -- Water elemental cave (Trapwood)
		teleport_pos = Position(32624, 33001, 9),
	},
	[29901] = { -- Water elemental cave (Trapwood)
		teleport_pos = Position(32651, 32983, 9),
	},
	[29902] = { -- Water elemental cave (Trapwood)
		teleport_pos = Position(32608, 32978, 8),
	},
}

local teleport_action = Action()

function teleport_action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local teleport_action = configAction[item.actionid]
	if not teleport_action or not player then
		return false
	end
		
	if teleport_action then
		local playerPos = player:getPosition()
		player:teleportTo(teleport_action.teleport_pos)
		playerPos:sendMagicEffect(CONST_ME_TELEPORT)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	
	return true
end

for index, value in pairs(configAction) do
	teleport_action:aid(index)
end
teleport_action:register()

