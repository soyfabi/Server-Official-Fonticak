local flowerBowl = MoveEvent()

function flowerBowl.onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		return true
	end

	if item.actionid == 34525 then
		if creature:getName() == 'Unbeatable Dragon' then
			creature:say('An allergic reaction weakens the dragon!', TALKTYPE_MONSTER_SAY)
			creature:remove()
			Game.createMonster('Somewhat Beatable', position, true, true)
		end
	end
	return true
end

flowerBowl:type("stepin")
flowerBowl:id(24841)
flowerBowl:register()