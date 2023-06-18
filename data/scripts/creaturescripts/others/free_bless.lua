local free_bless = CreatureEvent("free bless")
function free_bless.onLogin(player)
    freeBless = {
        level = 50,
        blesses = {1, 2, 3, 4, 5}
    }
	
	if player:getLevel() <= freeBless.level then
		for i = 1, #freeBless.blesses do
			if player:hasBlessing(i) then
				return true
			end
		end
		
		player:getPosition():sendMagicEffect(50)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received adventurers blessings for you to be level less than ".. freeBless.level ..".")
		for i = 1, #freeBless.blesses do
			player:addBlessing(freeBless.blesses[i])
		end
	end
	return true
end
free_bless:register()