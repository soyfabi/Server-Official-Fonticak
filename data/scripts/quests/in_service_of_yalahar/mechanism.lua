local mechanisms = {
	[3091] = {pos = {x = 32745, y = 31161, z = 5}, value = 21}, -- Alchemist
	[3092] = {pos = {x = 32745, y = 31164, z = 5}, value = 21},
	[3093] = {pos = {x = 32834, y = 31269, z = 5}, value = 24}, -- Trade
	[3094] = {pos = {x = 32834, y = 31266, z = 5}, value = 24},
	[3095] = {pos = {x = 32729, y = 31201, z = 5}, value = 29}, -- Arena
	[3096] = {pos = {x = 32734, y = 31201, z = 5}, value = 29},
	[3097] = {pos = {x = 32776, y = 31141, z = 5}, value = 35}, -- Cemetery
	[3098] = {pos = {x = 32776, y = 31145, z = 5}, value = 35},
	[3099] = {pos = {x = 32874, y = 31201, z = 5}, value = 41}, -- Sunken
	[3100] = {pos = {x = 32869, y = 31201, z = 5}, value = 41},
	[3101] = {pos = {x = 32856, y = 31251, z = 5}, value = 45}, -- Factory
	[3102] = {pos = {x = 32854, y = 31248, z = 5}, value = 45}
}

local mechanisms2 = {
	[1018] = {pos = {x = 32773, y = 31116, z = 7}},
	[1019] = {pos = {x = 32780, y = 31115, z = 7}}
}

local inServiceYalaharMechanism = Action()

local exhaust = {}
local exhaustTime = 1

function inServiceYalaharMechanism.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	if(mechanisms[item.uid]) then
		if(player:getStorageValue(Storage.InServiceofYalahar.Questline) >= mechanisms[item.uid].value) then
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(mechanisms[item.uid].pos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The gate mechanism won't move. You probably have to find a way around until you figure out how to operate the gate.")
		end
	elseif(mechanisms2[item.uid]) then
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:teleportTo(mechanisms2[item.uid].pos)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	exhaust[playerId] = currentTime + exhaustTime
	return true
end

inServiceYalaharMechanism:uid(1018,1019)
for value = 3091, 3102 do
	inServiceYalaharMechanism:uid(value)
end
inServiceYalaharMechanism:register()