local inServiceYalaharFormula = Action()
function inServiceYalaharFormula.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains({2535, 2537, 2539, 2541, 8997}, target.itemid) then
		return false
	end
	player:setStorageValue(Storage.InServiceofYalahar.GoodSide, 0)
	player:setStorageValue(Storage.InServiceofYalahar.AlchemistFormula, 1)
	item:remove(1)
	toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
	player:say("You burned the alchemist formula.", TALKTYPE_MONSTER_SAY)
	return true
end

inServiceYalaharFormula:id(8818)
inServiceYalaharFormula:register()