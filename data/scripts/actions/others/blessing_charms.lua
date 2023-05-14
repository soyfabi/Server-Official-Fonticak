local items = {
	[10341] = {text = "The Spiritual Shielding protects you.", id = 1, effect = CONST_ME_LOSEENERGY},
	[10342] = {text = "The Embrace of Tibia surrounds you.", id = 2, effect = CONST_ME_MAGIC_BLUE},
	[10343] = {text = "The Fire of the Suns engulfs you.", id = 3, effect = CONST_ME_MAGIC_RED},
	[10344] = {text = "The Wisdom of Solitude inspires you.", id = 4, effect = CONST_ME_MAGIC_GREEN},
	[10345] = {text = "The Spark of the Phoenix emblazes you.", id = 5, effect = CONST_ME_FIREATTACK},
	
	--Fix--
	[25360] = {text = "The Spark of the Phoenix emblazes you.", id = 6, effect = CONST_ME_FIREATTACK},
	[25361] = {text = "The Spark of the Phoenix emblazes you.", id = 7, effect = CONST_ME_FIREATTACK},
}

local blessingCharms = Action()

function blessingCharms.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local blessItem = items[item.itemid]
	if blessItem then
		if player:hasBlessing(blessItem.id) then
			player:say("You already possess this blessing.", TALKTYPE_MONSTER_SAY)
			return true
		end
		player:addBlessing(blessItem.id)
		player:say(blessItem.text, TALKTYPE_MONSTER_SAY)
		player:getPosition():sendMagicEffect(blessItem.effect)
		item:remove()
	end
	return true
end

for k, v in pairs(items) do
	blessingCharms:id(k)
end
blessingCharms:register()
