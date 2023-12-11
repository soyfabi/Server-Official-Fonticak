local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "arrow", id = 3447, buy = 3 },
	{ name = "axe", id = 3274, buy = 20, sell = 7 },
	{ name = "battle axe", id = 3266, buy = 235, sell = 80 },
	{ name = "battle hammer", id = 3305, buy = 350, sell = 120 },
	{ name = "blue quiver", id = 35848, buy = 400 },
	{ name = "bolt", id = 3446, buy = 4 },
	{ name = "bone club", id = 3337, sell = 5 },
	{ name = "bone sword", id = 3338, buy = 75, sell = 20 },
	{ name = "bow", id = 3350, buy = 400 },
	{ name = "carlin sword", id = 3283, buy = 473, sell = 118 },
	{ name = "club", id = 3270, buy = 5, sell = 1 },
	{ name = "crossbow", id = 3349, buy = 500 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "dagger", id = 3267, buy = 5, sell = 2 },
	{ name = "double axe", id = 3275, sell = 260 },
	{ name = "durable exercise axe", id = 35280, buy = 945000, count = 1800 },
	{ name = "durable exercise bow", id = 35282, buy = 945000, count = 1800 },
	{ name = "durable exercise club", id = 35281, buy = 945000, count = 1800 },
	{ name = "durable exercise sword", id = 35279, buy = 945000, count = 1800 },
	{ name = "exercise axe", id = 28553, buy = 262500, count = 500 },
	{ name = "exercise bow", id = 28555, buy = 262500, count = 500 },
	{ name = "exercise club", id = 28554, buy = 262500, count = 500 },
	{ name = "exercise sword", id = 28552, buy = 262500, count = 500 },
	{ name = "fire sword", id = 3280, sell = 1000 },
	{ name = "halberd", id = 3269, sell = 310 },
	{ name = "hand axe", id = 3268, buy = 8, sell = 4 },
	{ name = "hatchet", id = 3276, sell = 25 },
	{ name = "katana", id = 3300, sell = 35 },
	{ name = "lasting exercise axe", id = 35286, buy = 7560000, count = 14400 },
	{ name = "lasting exercise bow", id = 35288, buy = 7560000, count = 14400 },
	{ name = "lasting exercise club", id = 35287, buy = 7560000, count = 14400 },
	{ name = "lasting exercise sword", id = 35285, buy = 7560000, count = 14400 },
	{ name = "longsword", id = 3285, buy = 160, sell = 51 },
	{ name = "mace", id = 3286, buy = 90 },
	{ name = "morning star", id = 3282, buy = 430 },
	{ name = "quiver", id = 35562, buy = 400 },
	{ name = "rapier", id = 3272, buy = 15 },
	{ name = "red quiver", id = 35849, buy = 400 },
	{ name = "sabre", id = 3273, buy = 35 },
	{ name = "short sword", id = 3294, buy = 26 },
	{ name = "sickle", id = 3293, buy = 7 },
	{ name = "spear", id = 3277, buy = 9 },
	{ name = "spike sword", id = 3271, buy = 8000 },
	{ name = "sword", id = 3264, buy = 85 },
	{ name = "throwing knife", id = 3298, buy = 25 },
	{ name = "two handed sword", id = 3265, buy = 950 },
	{ name = "war hammer", id = 3279, buy = 10000 }
}

	for i = 1, #buyList do
		table.insert(itemsList, buyList[i])
	end
	return itemsList
end

local function setNewTradeTable(table)
	local items, item = {}
	for i = 1, #table do
		item = table[i]
		items[item.id] = {itemId = item.id, buyPrice = item.buy, sellPrice = item.sell, subType = 0, realName = item.name}
	end
	return items
end

local function onBuy(cid, item, subType, amount, ignoreCap, inBackpacks)
	local player = Player(cid)
	local items = setNewTradeTable(getTable(player))
	if not ignoreCap and player:getFreeCapacity() < ItemType(items[item].itemId):getWeight(amount) then
		return player:sendTextMessage(MESSAGE_INFO_DESCR, 'You don\'t have enough cap.')
	end
	if not player:removeMoneyNpc(items[item].buyPrice * amount) then
		selfSay("You don't have enough money.", cid)
	else
		player:addItem(items[item].itemId, amount)
		return player:sendTextMessage(MESSAGE_INFO_DESCR, 'Bought '..amount..'x '..items[item].realName..' for '..items[item].buyPrice * amount..' gold coins.')
	end
	return true
end

local function onSell(cid, item, subType, amount, ignoreCap, inBackpacks)
	local player = Player(cid)
	local items = setNewTradeTable(getTable(player))
	if items[item].sellPrice and player:removeItem(items[item].itemId, amount) then
		player:addMoney(items[item].sellPrice * amount)
		return player:sendTextMessage(MESSAGE_INFO_DESCR, 'Sold '..amount..'x '..items[item].realName..' for '..items[item].sellPrice * amount..' gold coins.')
	else
		selfSay("You don't have item to sell.", cid)
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local player = Player(cid)
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Of course, just browse through my wares. Or do you want to look only at {equipment}, {tools} or {weapons}?", cid)
	end
	
	if(msgcontains(msg, "piece of draconian steel")) then
		npcHandler:say("You bringing me draconian steel and obsidian lance in exchange for obsidian knife?", cid)
		npcHandler.topic[cid] = 15
	elseif(msgcontains(msg, "yes") and npcHandler.topic[cid] == 15) then
		if player:getItemCount(5889) >= 1 and player:getItemCount(2425) >= 1 then
			if player:removeItem(5889, 1) and player:removeItem(2425, 1) then
				npcHandler:say("Here you have it.", cid)
				player:addItem(5908, 1)
				npcHandler.topic[cid] = 0
			end
		else
			npcHandler:say("You don\'t have these items.", cid)
			npcHandler.topic[cid] = 0
		end
	end

	if(msgcontains(msg, "pickaxe")) then
		if player:getStorageValue(Storage.ExplorerSociety.JoiningTheExplorers) == 1 and player:getStorageValue(Storage.ExplorerSociety.QuestLine) == 1 then
			npcHandler:say("True dwarven pickaxes having to be maded by true weaponsmith! You wanting to get pickaxe for explorer society?", cid)
			npcHandler.topic[cid] = 1
		end
	elseif(msgcontains(msg, "crimson sword")) then
		if player:getStorageValue(Storage.TravellingTrader.Mission05) == 1 then
			npcHandler:say("Me don't sell crimson sword.", cid)
			npcHandler.topic[cid] = 5
		end
	elseif(msgcontains(msg, "forge")) then
		if(npcHandler.topic[cid] == 5) then
			npcHandler:say("You telling me to forge one?! Especially for you? You making fun of me?", cid)
			npcHandler.topic[cid] = 6
		end
	elseif(msgcontains(msg, "brooch")) then
		if player:getStorageValue(Storage.ExplorerSociety.JoiningTheExplorers) == 2 and player:getStorageValue(Storage.ExplorerSociety.QuestLine) == 2 then
			npcHandler:say("You got me brooch?", cid)
			npcHandler.topic[cid] = 3
		end
	elseif(msgcontains(msg, "yes")) then
		if(npcHandler.topic[cid] == 1) then
			npcHandler:say("Me order book quite full is. But telling you what: You getting me something me lost and Uzgod seeing that your pickaxe comes first. Jawoll! You interested?", cid)
			npcHandler.topic[cid] = 2
		elseif(npcHandler.topic[cid] == 2) then
			npcHandler:say("Good good. You listening: Me was stolen valuable heirloom. Brooch from my family. Good thing is criminal was caught. Bad thing is, criminal now in dwarven prison of dwacatra is and must have taken brooch with him ...", cid)
			npcHandler:say("To get into dwacatra you having to get several keys. Each key opening way to other key until you get key to dwarven prison ...", cid)
			npcHandler:say("Last key should be in the generals quarter near armory. Only General might have key to enter there too. But me not knowing how to enter Generals private room at barracks. You looking on your own ...", cid)
			npcHandler:say("When got key, then you going down to dwarven prison and getting me that brooch. Tell me that you got brooch when having it.", cid)
			npcHandler.topic[cid] = 0
			player:setStorageValue(Storage.ExplorerSociety.JoiningTheExplorers, 2)
			player:setStorageValue(Storage.ExplorerSociety.QuestLine, 2)
			player:setStorageValue(Storage.ExplorerSociety.DwacatraDoor, 1)
		elseif(npcHandler.topic[cid] == 3) then
			if player:removeItem(4834, 1) then -----
				npcHandler:say("Thanking you for brooch. Me guessing you now want your pickaxe?", cid)
				npcHandler.topic[cid] = 4
			end
		elseif(npcHandler.topic[cid] == 4) then
			npcHandler:say("Here you have it.", cid)
			player:addItem(4845, 1) -----
			player:setStorageValue(Storage.ExplorerSociety.JoiningTheExplorers, 4)
			player:setStorageValue(Storage.ExplorerSociety.QuestLine, 4)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 9) then
			if player:getMoney() + player:getBankBalance() >= 250 and player:getItemCount(5880) >= 3 then
				if player:removeMoneyNpc(250) and player:removeItem(5880, 3) then
					npcHandler:say("Ah, that's how me like me customers. Ok, me do this... <pling pling> ... another fine swing of the hammer here and there... <ploing>... here you have it!", cid)
					player:addItem(7385, 1)
					player:setStorageValue(Storage.TravellingTrader.Mission05, 2)
					npcHandler.topic[cid] = 0
				end
			end
		end
	elseif(msgcontains(msg, "no")) then
		if(npcHandler.topic[cid] == 6) then
			npcHandler:say("Well. Thinking about it, me a smith, so why not. 1000 gold for your personal crimson sword. Ok?", cid)
			npcHandler.topic[cid] = 7
		elseif(npcHandler.topic[cid] == 7) then
			npcHandler:say("Too expensive?! You think me work is cheap? Well, if you want cheap, I can make cheap. Hrmpf. I make cheap sword for 300 gold. Ok?", cid)
			npcHandler.topic[cid] = 8
		elseif(npcHandler.topic[cid] == 8) then
			npcHandler:say("Cheap but good quality? Impossible. Unless... you bring material. Three iron ores, 250 gold. Okay?", cid)
			npcHandler.topic[cid] = 9
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
