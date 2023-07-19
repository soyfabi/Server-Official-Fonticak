local talk = TalkAction("!boost", "!boosted", "!bonus")

local exhaust = {}
local exhaustTime = 2

function talk.onSay(player, words, param)
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("This Commands is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
		return false
	end
	
	
	
	local text = "[Boosted System]\nAll the bonuses you have activated will be displayed.\n\n"
	
	if player:getStorageValue(Storage.isCasting) == 1 then
		text = text .. "Cast System: On.\n"
		text = text .. "[+] Exp Bonus: +10%.\n\n"
	else
		text = text .. "Cast System: Off.\n\n"
	end	
	
	local guild = player:getGuild()
	if guild then
		text = text .. "Guild Bonus: On.\n"
		text = text .. "[+] Exp Bonus: " .. GuildLevel.level_experience[guild:getLevel()].exp .. "%.\n"
		text = text .. "[+] Loot Bonus: " .. GuildLevel.level_experience[guild:getLevel()].loot .. "%.\n\n"
	else
		text = text .. "Guild Bonus: Off.\n\n"
	end
	
	if player:getStorageValue(Storage.STORAGEVALUE_POTIONXP_ID) == 1 then
		text = text .. "Exp Potion: On.\n"
		text = text .. "[+] Exp Bonus: 25%.\n\n"
	else
		text = text .. "Exp Potion: Off.\n\n"
	end
	
	if player:getStorageValue(Storage.STORAGEVALUE_LOOT_ID) == 1 then
		text = text .. "Loot Potion: On.\n"
		text = text .. "[+] Loot Bonus: 25%.\n\n"
	else
		text = text .. "Loot Potion: Off.\n\n"
	end
	
	if player:getStorageValue(Storage.STORAGEVALUE_LOOT_ID) == 1 then
		text = text .. "Castle Bonus: On.\n"
		text = text .. "[+] Exp Bonus: 25%.\n\n"
	else
		text = text .. "Castle Bonus: Off.\n\n"
	end
	
	
	text = text .. "Total Experience Bonus: 50%."
	

	--exhaust[playerId] = currentTime + exhaustTime
	player:popupFYI(text)
    return false
end

talk:separator(" ")
talk:register()
