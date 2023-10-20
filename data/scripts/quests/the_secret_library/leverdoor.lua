local leverDoor = Action()

function leverDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheSecretLibrary.Mota) == 3 then
		player:setStorageValue(Storage.TheSecretLibrary.Mota, 4)
		player:setStorageValue(Storage.TheSecretLibrary.MotaDoor, 1)
		toPosition:sendMagicEffect(CONST_ME_HITAREA)
		Position(33250, 32039, 8):sendMagicEffect(CONST_ME_FIREATTACK)
		Position(33252, 32039, 8):sendMagicEffect(CONST_ME_FIREATTACK)
		return true
	end
	return false
end

leverDoor:uid(1084)
leverDoor:register()
