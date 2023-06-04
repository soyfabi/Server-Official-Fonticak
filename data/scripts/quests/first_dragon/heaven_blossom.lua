local heavenBlossom = MoveEvent()

function heavenBlossom.onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		return true
	end

	if item.actionid == 34525 then
		if creature:getName() == 'Spirit of Fertility' then
		creature:say('An allergic reaction weakens the dragon!', TALKTYPE_MONSTER_SAY)
		creature:remove()
		Game.createMonster('Angry Plant', position, true, true)
		creature:say('The fertile spirit brings a plant monster to life!', TALKTYPE_MONSTER_SAY)
		end
	end
	return true
end

heavenBlossom:id(3657)
heavenBlossom:register()