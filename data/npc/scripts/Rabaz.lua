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
	{ name = "avalanche rune", id = 3161, buy = 57 },
	{ name = "blank rune", id = 3147, buy = 10 },
	{ name = "chameleon rune", id = 3178, buy = 210 },
	{ name = "convince creature rune", id = 3177, buy = 80 },
	{ name = "cure poison rune", id = 3153, buy = 65 },
	{ name = "destroy field rune", id = 3148, buy = 15 },
	{ name = "durable exercise rod", id = 35283, buy = 945000, count = 1800 },
	{ name = "durable exercise wand", id = 35284, buy = 945000, count = 1800 },
	{ name = "empty potion flask", id = 283, sell = 5 },
	{ name = "empty potion flask", id = 284, sell = 5 },
	{ name = "empty potion flask", id = 285, sell = 5 },
	{ name = "energy field rune", id = 3164, buy = 38 },
	{ name = "energy wall rune", id = 3166, buy = 85 },
	{ name = "exercise rod", id = 28556, buy = 262500, count = 500 },
	{ name = "exercise wand", id = 28557, buy = 262500, count = 500 },
	{ name = "explosion rune", id = 3200, buy = 31 },
	{ name = "fire bomb rune", id = 3192, buy = 147 },
	{ name = "fire field rune", id = 3188, buy = 28 },
	{ name = "fire wall rune", id = 3190, buy = 61 },
	{ name = "great fireball rune", id = 3191, buy = 57 },
	{ name = "great health potion", id = 239, buy = 225 },
	{ name = "great mana potion", id = 238, buy = 144 },
	{ name = "great spirit potion", id = 7642, buy = 228 },
	{ name = "hailstorm rod", id = 3067, buy = 15000 },
	{ name = "health potion", id = 266, buy = 50 },
	{ name = "heavy magic missile rune", id = 3198, buy = 12 },
	{ name = "intense healing rune", id = 3152, buy = 95 },
	{ name = "lasting exercise rod", id = 35289, buy = 7560000, count = 14400 },
	{ name = "lasting exercise wand", id = 35290, buy = 7560000, count = 14400 },
	{ name = "light magic missile rune", id = 3174, buy = 4 },
	{ name = "mana potion", id = 268, buy = 56 },
	{ name = "moonlight rod", id = 3070, buy = 1000 },
	{ name = "necrotic rod", id = 3069, buy = 5000 },
	{ name = "northwind rod", id = 8083, buy = 7500 },
	{ name = "poison field rune", id = 3172, buy = 21 },
	{ name = "poison wall rune", id = 3176, buy = 52 },
	{ name = "snakebite rod", id = 3066, buy = 500 },
	{ name = "spellbook", id = 3059, buy = 150 },
	{ name = "spellwand", id = 651, sell = 299 },
	{ name = "springsprout rod", id = 8084, buy = 18000 },
	{ name = "stalagmite rune", id = 3179, buy = 12 },
	{ name = "strong health potion", id = 236, buy = 115 },
	{ name = "strong mana potion", id = 237, buy = 93 },
	{ name = "sudden death rune", id = 3155, buy = 135 },
	{ name = "supreme health potion", id = 23375, buy = 625 },
	{ name = "terra rod", id = 3065, buy = 10000 },
	{ name = "ultimate healing rune", id = 3160, buy = 175 },
	{ name = "ultimate health potion", id = 7643, buy = 379 },
	{ name = "ultimate mana potion", id = 23373, buy = 438 },
	{ name = "ultimate spirit potion", id = 23374, buy = 438 },
	{ name = "underworld rod", id = 8082, buy = 22000 },
	{ name = "vial", id = 2874, sell = 5 },
	{ name = "wand of cosmic energy", id = 3073, buy = 10000 },
	{ name = "wand of decay", id = 3072, buy = 5000 },
	{ name = "wand of draconia", id = 8093, buy = 5000 },
	{ name = "wand of dragonbreath", id = 3075, buy = 1000 },
	{ name = "wand of inferno", id = 3071, buy = 15000 },
	{ name = "wand of starstorm", id = 8092, buy = 18000 },
	{ name = "wand of voodoo", id = 8094, buy = 22000 },
	{ name = "wand of vortex", id = 3074, buy = 500 }
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
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	
	local player = Player(cid)
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Of course, just browse through my wares. Or do you want to look only at {potions}, {wands} or {runes}?", cid)
	end
	
	if msgcontains(msg, "mission") then
		if player:getStorageValue(Storage.TibiaTales.AnInterestInBotany) < 1 then
			npcHandler.topic[cid] = 1
				npcHandler:say({
					"Why yes, there is indeed some minor issue I could need your help with. I was always a friend of nature and it was not recently I discovered the joys of plants, growths, of all the flora around us. ...",
					"Botany my friend. The study of plants is of great importance for our future. Many of the potions we often depend on are made of plants you know. Plants can help us tending our wounds, cure us from illness or injury. ...",
					"I am currently writing an excessive compilation of all the knowledge I have gathered during my time here in Farmine and soon hope to publish it as 'Rabaz' Unabridged Almanach Of Botany'. ...",
					"However, to actually complete my botanical epitome concerning Zao, I would need someone to enter these dangerous lands. Someone able to get closer to the specimens than I can. ...",
					"And this is where you come in. There are two extremely rare species I need samples from. Typically not easy to come by but it should not be necessary to venture too far into Zao to find them. ...",
					"Explore the anterior outskirts of Zao, use my almanach and find the two specimens with missing samples on their pages. The almanach can be found in a chest in my storage, next to my shop. It's the door over there. ...",
					"If you lose it I will have to write a new one and put it in there again - which will undoubtedly take me a while. So keep an eye on it on your travels. ...",
					"Once you find what I need, best use a knife to carefully cut and gather a leaf or a scrap of their integument and press it directly under their appropriate entry into my botanical almanach. ...",
					"Simply return to me after you have done that and we will discuss your reward. What do you say, are you in?"
				}, cid)
		elseif player:getStorageValue(Storage.TibiaTales.AnInterestInBotany) == 3 then
			npcHandler.topic[cid] = 2
			npcHandler:say("Well fantastic work, you gathered both samples! Now I can continue my work on the almanach, thank you very much for your help indeed. Can I take a look at my book please?", cid)
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			player:setStorageValue(Storage.TibiaTales.DefaultStart, 1)
			player:setStorageValue(Storage.TibiaTales.AnInterestInBotany, 1)
			player:setStorageValue(Storage.TibiaTales.AnInterestInBotanyChestDoor, 0)
			npcHandler:say("Yes? Yes! That's the enthusiasm I need! Remember to bring a sharp knife to gather the samples, plants - even mutated deformed plants - are very sensitive you know. Off you go and be careful out there, Zao is no place for the feint hearted mind you.", cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			if player:removeItem(11699, 1) then
				player:addItem(11700, 1)
				player:addItem(3035, 10)
				player:addExperience(3000, true)
				player:setStorageValue(Storage.TibiaTales.AnInterestInBotany, 4)
				npcHandler:say({
					"Ah, thank you. Now look at that texture and fine colour, simply marvellous. ...",
					"I hope the sun in the steppe did not exhaust you too much? Shellshock. A dangerous foe in the world of field science and exploration. ...",
					"Here, I always wore this comfortable hat when travelling, take it. It may be of use for you on further reconnaissances in Zao. Again you have my thanks, friend."
				}, cid)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("Oh, you don't have my book.", cid)
				npcHandler.topic[cid] = 0
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
