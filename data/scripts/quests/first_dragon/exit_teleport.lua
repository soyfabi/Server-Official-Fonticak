local UniqueTable = {
	-- Tazhadur exit
	[35005] = {
		backPos  = {x = 33234, y = 32278, z = 12},
		range = 10,
		bossName = "Tazhadur",
		bossPos = {x = 32018, y = 32465, z = 8}
	},
	-- Kalyassa exit
	[35006] = {
		backPos  = {x = 33162, y = 31320, z = 5},
		range = 10,
		bossName = "Kalyassa",
		bossPos = {x = 32079, y = 32459, z = 8}
	},
	-- Zorvorax exit
	[35007] = {
		backPos  = {x = 33002, y = 31595, z = 11},
		range = 10,
		bossName = "Zorvorax",
		bossPos = {x = 32015, y = 32396, z = 8}
	},
	-- Gelidrazah exit
	[35008] = {
		backPos  = {x = 32278, y = 31367, z = 4},
		range = 10,
		bossName = "Gelidrazah The Frozen",
		bossPos = {x = 32078, y = 32400, z = 8}
	}
}

local exitTeleport = MoveEvent()
function exitTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local setting = UniqueTable[item.uid]
	if not setting then
		return true
	end
	
	local monster = Game.createMonster(setting.bossName, setting.bossPos, true, true)
	if not monster then
		return true
	end
	
	addEvent(clearBossRoom, 0, player.uid, monster.uid, setting.bossPos, setting.range, setting.range, fromPosition)	
	player:teleportTo(setting.backPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

for index, value in pairs(UniqueTable) do
	exitTeleport:uid(index)
end

exitTeleport:register()
