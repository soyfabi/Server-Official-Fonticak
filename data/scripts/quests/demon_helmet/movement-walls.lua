local tilesPositions = {
	{x = 33190, y = 31629, z = 13},
	{x = 33191, y = 31629, z = 13}
}

local wallsPositions = {
	{x = 33210, y = 31630, z = 13},
	{x = 33211, y = 31630, z = 13},
	{x = 33212, y = 31630, z = 13}
}

local walls = MoveEvent()
walls:type("stepin")

function walls.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local tileCreature1 = Tile(tilesPositions[1]):getTopCreature()
	local tileCreature2 = Tile(tilesPositions[2]):getTopCreature()
	-- Check 2 tiles positions have a creature and it is a player
	if tileCreature1 and tileCreature1:getPlayer() or tileCreature2 and tileCreature2:getPlayer() then
		player:say("The walls have been removed.")
		for i = 1, #wallsPositions do
			wall = Tile(wallsPositions[i]):getItemById(1295)
			-- Check there walls before delete them
			if wall then
				wall:remove()
			end
		end
	end
	return true
end

for index, value in pairs(tilesPositions) do
	walls:position(value)
end

walls:register()

walls = MoveEvent()
walls:type("stepout")

function walls.onStepOut(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	for i = 1, #wallsPositions do
		wall = Tile(wallsPositions[i]):getItemById(1295)
		-- Check there is no walls before create new ones
	end
	return true
end

for index, value in pairs(tilesPositions) do
	walls:position(value)
end

walls:register()
