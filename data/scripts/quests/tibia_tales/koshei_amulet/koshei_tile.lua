local kosheiTile = MoveEvent()
function kosheiTile.onStepIn(creature, item, position, fromPosition)
	if creature:getStorageValue(Storage.KosheiTheDeathless.KosheiMission) == 1 then
		creature:setStorageValue(Storage.KosheiTheDeathless.KosheiMission, 2)
	end
	return true
end


kosheiTile:aid(50742)
kosheiTile:register()