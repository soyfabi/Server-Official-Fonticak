local trainersConfig = {
	first_room_pos = Position(29460, 32631, 4), -- posicao da primeira pos (linha 1 coluna 1)
	distX= 12, -- distancia em X entre cada sala (de uma mesma linha)
	distY= 21, -- distancia em Y entre cada sala (de uma mesma coluna)
	rX= 6, -- numero de colunas
	rY= 8 -- numero de linhas
}

local function isBusyable(position)
	local player = Tile(position):getTopCreature()
	if player then
		if player:isPlayer() then
			return false
		end
	end

	local tile = Tile(position)
	if not tile then
		return false
	end

	local ground = tile:getGround()
	if not ground or ground:hasProperty(CONST_PROP_BLOCKSOLID) then
		return false
	end

	local items = tile:getItems()
	for i = 1, tile:getItemCount() do
		local item = items[i]
		local itemType = item:getType()
		if itemType:getType() ~= ITEM_TYPE_MAGICFIELD and not itemType:isMovable() and item:hasProperty(CONST_PROP_BLOCKSOLID) then
			return false
		end
	end

	return true
end

local function addTrainers(position, arrayPos)
	if not isBusyable(position) then
		for places = 1, #arrayPos do
			local trainer = Tile(arrayPos[places]):getTopCreature()
			if not trainer then
				local monster = Game.createMonster("Training Fonticak", arrayPos[places])
				monster:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			end
		end
	end
end

local function calculatingRoom(uid, position, coluna, linha)
	local player = Player(uid)
	if coluna >= trainersConfig.rX then
		coluna = 0
		linha = linha < (trainersConfig.rY -1) and linha + 1 or false
	end

	if linha then
		local room_pos = {x = position.x + (coluna * trainersConfig.distX), y = position.y + (linha * trainersConfig.distY), z = position.z}
		if isBusyable(room_pos) then
			player:teleportTo(room_pos)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			addTrainers(room_pos, {{x = room_pos.x - 1, y = room_pos.y - 1, z = room_pos.z}, {x = room_pos.x + 1 , y = room_pos.y - 1, z = room_pos.z}})
		else
			calculatingRoom(uid, position, coluna + 1, linha)
		end
	else
		player:sendCancelMessage("Right now the trainers are full, come back later.")
	end
end

local trainer_enter = MoveEvent()

local exhaust = {}
local exhaustTime = 10

function trainer_enter.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	
	local playerId = creature:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		creature:sendCancelMessage("You are on cooldown, for getting out of trainer very quickly, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
		creature:teleportTo(fromPosition, true)
		return true
	end
	
	exhaust[playerId] = currentTime + exhaustTime
	calculatingRoom(creature.uid, trainersConfig.first_room_pos, 0, 0)
	return true
end

trainer_enter:aid(65000)
trainer_enter:register()

local trainer_leave = MoveEvent()

function trainer_leave.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end
	
	local function removeTrainers(position)
		local arrayPos = {{x = position.x - 1, y = position.y - 1, z = position.z}, {x = position.x + 1 , y = position.y - 1, z = position.z}}
		for places = 1, #arrayPos do
			local trainer = Tile(arrayPos[places]):getTopCreature()
			if trainer then
				if trainer:isMonster() then
					trainer:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					trainer:remove()
				end
			end
		end
	end

	removeTrainers(fromPosition)
	creature:teleportTo(creature:getTown():getTemplePosition())
	creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

trainer_leave:aid(65001)
trainer_leave:register()
