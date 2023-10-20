local druidWaterSkin = Action()
function druidWaterSkin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid ~= 5662 then
		return false
	end

	toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
	player:say('Has been filled with water.', TALKTYPE_MONSTER_SAY, false, player, toPosition)
	item:transform(5939)
	return true
end

druidWaterSkin:id(5938)
druidWaterSkin:register()
