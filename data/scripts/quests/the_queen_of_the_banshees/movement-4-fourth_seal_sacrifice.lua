local fourthSealSacrifice = MoveEvent()

function fourthSealSacrifice.onAddItem(moveitem, tileitem, position)
	if moveitem.itemid ~= 2886 or moveitem.type ~= 5 then
		return true
	end

	for i = 1, #fourthSealTable.positions do
		Position(fourthSealTable.positions[i]):sendMagicEffect(CONST_ME_DRAWBLOOD)
	end
	return true
end

fourthSealSacrifice:tileItem(true)
fourthSealSacrifice:type("additem")
fourthSealSacrifice:id(431)
fourthSealSacrifice:register()
