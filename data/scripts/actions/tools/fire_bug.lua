local fireBug = Action()

function fireBug.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	--Dreamer Challenge Quest
	if target.uid == 2243 then
		target:transform(1387)
		toPosition:sendMagicEffect(CONST_ME_FIREAREA)
		item:remove()
		return true
	end

	-- The Hidden City of Beregar
	
	if target.itemid == 7813 and target.actionid == 50120 then
		player:say("The crucible is already full of coal.")
		return true
	end
	
	local crucibleItem = Tile(Position(32699, 31494, 11)):getItemById(7814)
	
	if target.itemid == 7814 and target.actionid == 50120 then
		target:transform(7813)
		Tile(Position(32699, 31495, 11)):getItemById(9121):remove()
		Game.createItem(9120, 1, Position(32699, 31495, 11)):setActionId(50110)
		return true
	end

	local chance = math.random(10)
	if chance > 4 then -- Success 6% chance
		if target.itemid == 182 then -- Destroy spider webs/North - South
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(188)
			target:decay()
		elseif target.itemid == 183 then -- Destroy spider webs/East - West
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(189)
			target:decay()
		elseif target.itemid == 5465 then -- Burn Sugar Cane
			toPosition:sendMagicEffect(CONST_ME_FIREAREA)
			target:transform(5464)
			target:decay()
		elseif target.itemid == 2114 then -- Light up empty coal basins
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(2113)
		end
	elseif chance == 2 then -- It removes the firebug 1% chance
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_POFF)
	elseif chance == 1 then -- It explodes on the user 1% chance
		doTargetCombatHealth(0, player, COMBAT_FIREDAMAGE, -5, -5, CONST_ME_HITBYFIRE)
		player:say('OUCH!', TALKTYPE_MONSTER_SAY)
		item:remove(1)
	else
		toPosition:sendMagicEffect(CONST_ME_POFF) -- It fails, but don't get removed 3% chance
	end
	return true
end

fireBug:id(5467)
fireBug:register()