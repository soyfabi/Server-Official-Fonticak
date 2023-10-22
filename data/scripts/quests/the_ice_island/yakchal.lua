local creatureName = {
	[1] = 'ice golem',
	[2] = 'ice witch',
	[3] = 'crystal spider',
	[4] = 'frost dragon'
}

local function summonMonster(name, position)
	Game.createMonster(name, position)
	position:sendMagicEffect(CONST_ME_TELEPORT)
end

local iceYakchal = Action()
function iceYakchal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local sarcophagus = Position(32205, 31002, 14)
	if toPosition.x == sarcophagus.x and toPosition.y == sarcophagus.y and toPosition.z == sarcophagus.z and target.itemid == 7362 then
		if getGlobalStorageValue(GlobalStorage.Yakchal) < os.time() then
			setGlobalStorageValue(GlobalStorage.Yakchal, os.time() + 24 * 60 * 60)
			if math.random(2) == 2 then
				player:say("You have awoken the icewitch Yakchal from her slumber! She seems not amused...", TALKTYPE_MONSTER_SAY)
			else
				player:say("The frozen starlight shattered, but you have awoken the icewitch Yakchal from her slumber! She seems not amused...", TALKTYPE_MONSTER_SAY)
				item:remove(1)
			end
			Position(Position(32204, 31002, 14):sendMagicEffect(CONST_ME_FIREWORK_BLUE))
			Position(Position(32205, 31002, 14):sendMagicEffect(CONST_ME_FIREWORK_BLUE))
			Position(Position(32206, 31002, 14):sendMagicEffect(CONST_ME_FIREWORK_BLUE))
			Position(Position(32205, 31001, 14):sendMagicEffect(CONST_ME_FIREWORK_BLUE))
			Position(Position(32205, 31000, 14):sendMagicEffect(CONST_ME_FIREWORK_BLUE))
			Position(Position(32205, 31003, 14):sendMagicEffect(CONST_ME_FIREWORK_BLUE))
			Game.createMonster("Yakchal", toPosition)
			local creature, pos
			for i = 1, 4 do
				creature = creatureName[i]
				for k = 1, 70 do
					pos = Position(math.random(32193, 32215), math.random(30985, 31014), 14)
					if math.random(i + 1) == 1 then
						addEvent(summonMonster, (i - 1) * 10 * 1000, creature, pos)
					end
				end
			end
		else
			player:say("Yakchal has already been awakened today. You should try again tomorrow.", TALKTYPE_MONSTER_SAY)
		end
	end
	return true
end

iceYakchal:id(3249)
iceYakchal:register()