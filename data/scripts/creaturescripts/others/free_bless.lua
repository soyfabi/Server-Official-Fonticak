local freeBless = {
	level = 50,
	blesses = {1, 2, 3, 4, 5}
}

local free_bless = CreatureEvent("free bless")
function free_bless.onLogin(player)
	if player:getLevel() <= freeBless.level then
		for i = 1, #freeBless.blesses do
			if player:hasBlessing(i) then
				return true
			end
		end
		
		player:getPosition():sendMagicEffect(50)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received adventurers blessings for you to be level less than ".. freeBless.level ..".\nIf you die while PK you will lose the free bless.")
		for i = 1, #freeBless.blesses do
			player:addBlessing(freeBless.blesses[i])
		end
	end
	return true
end
free_bless:register()

local freeblesspk = CreatureEvent("FreeBlessPK")
function freeblesspk.onKill(player, target)
	if target:isMonster() then
		return false
	end
	
	if target:getLevel() <= freeBless.level then
		if target:getSkull() == SKULL_WHITE or target:isPzLocked() then
			for i = 1, #freeBless.blesses do
				target:removeBlessing(freeBless.blesses[i])
			end
			target:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You lost the free bless for having PK or PZ.")
		end
	end
	return true
end

freeblesspk:register()