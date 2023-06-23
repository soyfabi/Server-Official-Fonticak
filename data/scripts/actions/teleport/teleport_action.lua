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

