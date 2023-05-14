local cake = MoveEvent()
function cake.onAddItem(moveitem, tileitem, position)
	if moveitem:getId() == 2918 then -- lit candlestick
		tileitem:transform(6279) -- party cake
		tileitem:decay()
		moveitem:remove(1)
		position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
	return true
end

cake:id(6278) -- decorated cake
cake:tileItem(true)
cake:register()
