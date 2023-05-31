local demonOakGrave = Action()

local DEMON_OAK_REWARDROOM_POSITION = Position(32714, 32398, 8)

function demonOakGrave.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.DemonOak.Done) == 2 then
		player:teleportTo(DEMON_OAK_REWARDROOM_POSITION)
		player:setDirection(DIRECTION_EAST)
		DEMON_OAK_REWARDROOM_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
end

demonOakGrave:uid(1001)
demonOakGrave:register()