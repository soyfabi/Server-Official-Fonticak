local fireBug = Action()

function fireBug.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if target.actionid == 54387 and target.itemid == 22875 then
		if player:getStorageValue(Storage.FerumbrasAscension.BasinCounter) >= 8 or player:getStorageValue(Storage.FerumbrasAscension.BoneFlute) < 1 then
			return false
		end
		if player:getStorageValue(Storage.FerumbrasAscension.BasinCounter) < 0 then
			player:setStorageValue(Storage.FerumbrasAscension.BasinCounter, 0)
		end
		if player:getStorageValue(Storage.FerumbrasAscension.BasinCounter) == 7 then
			player:say('You ascended the last basin.', TALKTYPE_MONSTER_SAY)
			item:remove()
			player:setStorageValue(Storage.FerumbrasAscension.MonsterDoor, 1)
		end
		target:transform(22876)
		player:setStorageValue(Storage.FerumbrasAscension.BasinCounter, player:getStorageValue(Storage.FerumbrasAscension.BasinCounter) + 1)
		toPosition:sendMagicEffect(CONST_ME_FIREAREA)
		addEvent(revert, 2 * 60 * 1000, toPosition, 22876, 22875)
		return true
	elseif target.uid == 2243 then
		local tile = Tile(Position(32849, 32233, 9))
		local item = tile:getItemById(3134)
		local createTeleport = Game.createItem(1949, 1, Position(32849, 32233, 9))
		for k, v in pairs(positions) do
			v:sendMagicEffect(CONST_ME_YELLOW_RINGS)
		end
		item:remove()
		addEvent(revertAshes, 5 * 60 * 1000) -- 5 minutes
		createTeleport:setDestination(Position(32857, 32234, 11))
		return true
	elseif target.actionid == 50119 then
		target:transform(7813)
		return true
	end
	
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
			return true
		elseif target.actionid == 12550 or target.actionid == 12551 then -- Secret Service Quest
			if player:getStorageValue(Storage.SecretService.TBIMission01) == 1 then
				local newItem = Game.createItem(2118, 1, Position(32893, 32012, 6))
				
				addEvent(function()
					if newItem and newItem:isItem() then
						newItem:remove()
					end
				end, 10 * 1000)				
				player:setStorageValue(Storage.SecretService.TBIMission01, 2)
			end
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