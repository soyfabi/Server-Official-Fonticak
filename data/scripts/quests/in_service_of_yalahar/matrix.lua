local inServiceYalaharMatrix = Action()
function inServiceYalaharMatrix.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if table.contains({842, 843}, target.itemid) and target.actionid == 100 then
		if table.contains({8828, 8829}, item.itemid) and player:getStorageValue(Storage.InServiceofYalahar.MatrixState) < 1 then
			player:setStorageValue(Storage.InServiceofYalahar.MatrixState, 1)
			item:remove(1)
			toPosition:sendMagicEffect(CONST_ME_YELLOWENERGY)
			player:say("The machine was activated.", TALKTYPE_MONSTER_SAY)
			player:setStorageValue(Storage.InServiceofYalahar.Questline, 46)
			player:setStorageValue(Storage.InServiceofYalahar.Mission08, 3) -- StorageValue for Questlog "Mission 08: Dangerous Machinations"
		end
	end
	return true
end

inServiceYalaharMatrix:id(8828,8829)
inServiceYalaharMatrix:register()