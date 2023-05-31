function checkWallArito(item, toPosition)
	if (not item:isItem()) then
		return false
	end
	local wallTile = Tile(Position(33206, 32536, 6))
	if not wallTile or wallTile:getItemCountById(7181) > 0 then
		return false
	end
	local checkEqual = {
		[2886] = {Position(33207, 32537, 6), {5858, -1}, Position(33205, 32537, 6)},
		[3307] = {Position(33205, 32537, 6), {2016, 1}, Position(33207, 32537, 6), 5858}
	}
	local it = checkEqual[item:getId()]
	if (it and it[1] == toPosition and Tile(it[3]):getItemCountById(it[2][1], it[2][2]) > 0) then
		wallTile:getItemById(1085):transform(7181)

		if (it[4]) then
			item:transform(it[4])
		end

		addEvent(
		function()
			if (Tile(Position(33206, 32536, 6)):getItemCountById(7476) > 0) then
				Tile(Position(33206, 32536, 6)):getItemById(7476):transform(1085)
			end
			if (Tile(Position(33205, 32537, 6)):getItemCountById(5858) > 0) then
				Tile(Position(33205, 32537, 6)):getItemById(5858):remove()
			end
		end,
		5 * 60 * 1000
		)
	else
		if (it and it[4] and it[1] == toPosition) then
			item:transform(it[4])
		end
	end
end

function iterateArea(func, from, to)
	for z = from.z, to.z do
		for y = from.y, to.y do
			for x = from.x, to.x do
				func(Position(x, y, z))
			end
		end
	end
end

-- Blessing --
function getBlessingsCost(level)
    if level <= 30 then
        return 2000
    elseif level >= 120 then
        return 20000
    else
        return (level - 20) * 200
    end
end