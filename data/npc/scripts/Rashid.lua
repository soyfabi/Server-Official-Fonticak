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
	{ name = "abyss hammer", id = 7414, sell = 20000 },
	{ name = "albino plate", id = 19358, sell = 1500 },
	{ name = "amber staff", id = 7426, sell = 8000 },
	{ name = "amber staff", id = 7426, sell = 8000 },
	{ name = "ancient amulet", id = 3025, sell = 200 },
	{ name = "assassin dagger", id = 7404, sell = 20000 },
	{ name = "bandana", id = 5917, sell = 150 },
	{ name = "beastslayer axe", id = 3344, sell = 1500 },
	{ name = "beetle necklace", id = 10457, sell = 1500 },
	{ name = "berserker", id = 7403, sell = 40000 },
	{ name = "blacksteel sword", id = 7406, sell = 6000 },
	{ name = "blessed sceptre", id = 7429, sell = 40000 },
	{ name = "bone shield", id = 3441, sell = 80 },
	{ name = "bonelord helmet", id = 3408, sell = 7500 },
	{ name = "brutetamer's staff", id = 7379, sell = 1500 },
	{ name = "buckle", id = 17829, sell = 7000 },
	{ name = "castle shield", id = 3435, sell = 5000 },
	{ name = "chain bolter", id = 8022, sell = 40000 },
	{ name = "chaos mace", id = 7427, sell = 9000 },
	{ name = "cobra crown", id = 11674, sell = 50000 },
	{ name = "coconut shoes", id = 9017, sell = 500 },
	{ name = "composite hornbow", id = 8027, sell = 25000 },
	{ name = "cranial basher", id = 7415, sell = 30000 },
	{ name = "crocodile boots", id = 3556, sell = 1000 },
	{ name = "crystal crossbow", id = 16163, sell = 35000 },
	{ name = "crystal mace", id = 3333, sell = 12000 },
	{ name = "crystal necklace", id = 3008, sell = 400 },
	{ name = "crystal ring", id = 3007, sell = 250 },
	{ name = "crystal sword", id = 7449, sell = 600 },
	{ name = "crystalline armor", id = 8050, sell = 16000 },
	{ name = "daramian mace", id = 3327, sell = 110 },
	{ name = "daramian waraxe", id = 3328, sell = 1000 },
	{ name = "dark shield", id = 3421, sell = 400 },
	{ name = "death ring", id = 6299, sell = 1000 },
	{ name = "demon shield", id = 3420, sell = 30000 },
	{ name = "demonbone amulet", id = 3019, sell = 32000 },
	{ name = "demonrage sword", id = 7382, sell = 36000 },
	{ name = "devil helmet", id = 3356, sell = 1000 },
	{ name = "diamond sceptre", id = 7387, sell = 3000 },
	{ name = "divine plate", id = 8057, sell = 55000 },
	{ name = "djinn blade", id = 3339, sell = 15000 },
	{ name = "doll", id = 2991, sell = 200 },
	{ name = "dragon scale mail", id = 3386, sell = 40000 },
	{ name = "dragon slayer", id = 7402, sell = 15000 },
	{ name = "dragonbone staff", id = 7430, sell = 3000 },
	{ name = "dreaded cleaver", id = 7419, sell = 10000 },
	{ name = "dwarven armor", id = 3397, sell = 30000 },
	{ name = "elvish bow", id = 7438, sell = 2000 },
	{ name = "emerald bangle", id = 3010, sell = 800 },
	{ name = "epee", id = 3326, sell = 8000 },
	{ name = "flower dress", id = 9015, sell = 1000 },
	{ name = "flower wreath", id = 9013, sell = 500 },
	{ name = "fur boots", id = 7457, sell = 2000 },
	{ name = "furry club", id = 7432, sell = 1000 },
	{ name = "glacier amulet", id = 815, sell = 1500 },
	{ name = "glacier kilt", id = 823, sell = 11000 },
	{ name = "glacier mask", id = 829, sell = 2500 },
	{ name = "glacier robe", id = 824, sell = 11000 },
	{ name = "glacier shoes", id = 819, sell = 2500 },
	{ name = "gold ring", id = 3063, sell = 8000 },
	{ name = "golden armor", id = 3360, sell = 20000 },
	{ name = "golden legs", id = 3364, sell = 30000 },
	{ name = "goo shell", id = 19372, sell = 4000 },
	{ name = "griffin shield", id = 3433, sell = 3000 },
	{ name = "guardian halberd", id = 3315, sell = 11000 },
	{ name = "hammer of wrath", id = 3332, sell = 30000 },
	{ name = "headchopper", id = 7380, sell = 6000 },
	{ name = "heavy mace", id = 3340, sell = 50000 },
	{ name = "heavy machete", id = 3330, sell = 90 },
	{ name = "heavy trident", id = 12683, sell = 2000 },
	{ name = "helmet of the lost", id = 17852, sell = 2000 },
	{ name = "heroic axe", id = 7389, sell = 30000 },
	{ name = "hibiscus dress", id = 8045, sell = 3000 },
	{ name = "hieroglyph banner", id = 12482, sell = 500 },
	{ name = "horn", id = 19359, sell = 300 },
	{ name = "jade hammer", id = 7422, sell = 25000 },
	{ name = "krimhorn helmet", id = 7461, sell = 200 },
	{ name = "lavos armor", id = 8049, sell = 16000 },
	{ name = "leaf legs", id = 9014, sell = 500 },
	{ name = "leopard armor", id = 3404, sell = 1000 },
	{ name = "leviathan's amulet", id = 9303, sell = 3000 },
	{ name = "light shovel", id = 5710, sell = 300 },
	{ name = "lightning boots", id = 820, sell = 2500 },
	{ name = "lightning headband", id = 828, sell = 2500 },
	{ name = "lightning legs", id = 822, sell = 11000 },
	{ name = "lightning pendant", id = 816, sell = 1500 },
	{ name = "lightning robe", id = 825, sell = 11000 },
	{ name = "lunar staff", id = 7424, sell = 5000 },
	{ name = "magic plate armor", id = 3366, sell = 90000 },
	{ name = "magma amulet", id = 817, sell = 1500 },
	{ name = "magma boots", id = 818, sell = 2500 },
	{ name = "magma coat", id = 826, sell = 11000 },
	{ name = "magma legs", id = 821, sell = 11000 },
	{ name = "magma monocle", id = 827, sell = 2500 },
	{ name = "mammoth fur cape", id = 7463, sell = 6000 },
	{ name = "mammoth fur shorts", id = 7464, sell = 850 },
	{ name = "mammoth whopper", id = 7381, sell = 300 },
	{ name = "mastermind shield", id = 3414, sell = 50000 },
	{ name = "medusa shield", id = 3436, sell = 9000 },
	{ name = "mercenary sword", id = 7386, sell = 12000 },
	{ name = "model ship", id = 2994, sell = 1000 },
	{ name = "mycological bow", id = 16164, sell = 35000 },
	{ name = "mystic blade", id = 7384, sell = 30000 },
	{ name = "naginata", id = 3314, sell = 2000 },
	{ name = "nightmare blade", id = 7418, sell = 35000 },
	{ name = "noble axe", id = 7456, sell = 10000 },
	{ name = "norse shield", id = 7460, sell = 1500 },
	{ name = "onyx pendant", id = 22195, sell = 3500 },
	{ name = "orcish maul", id = 7392, sell = 6000 },
	{ name = "oriental shoes", id = 21981, sell = 15000 },
	{ name = "pair of iron fists", id = 17828, sell = 4000 },
	{ name = "paladin armor", id = 8063, sell = 15000 },
	{ name = "patched boots", id = 3550, sell = 2000 },
	{ name = "pharaoh banner", id = 12483, sell = 1000 },
	{ name = "pharaoh sword", id = 3334, sell = 23000 },
	{ name = "pirate boots", id = 5461, sell = 3000 },
	{ name = "pirate hat", id = 6096, sell = 1000 },
	{ name = "pirate knee breeches", id = 5918, sell = 200 },
	{ name = "pirate shirt", id = 6095, sell = 500 },
	{ name = "pirate voodoo doll", id = 5810, sell = 500 },
	{ name = "platinum amulet", id = 3055, sell = 2500 },
	{ name = "ragnir helmet", id = 7462, sell = 400 },
	{ name = "relic sword", id = 7383, sell = 25000 },
	{ name = "rift bow", id = 22866, sell = 45000 },
	{ name = "rift crossbow", id = 22867, sell = 45000 },
	{ name = "rift lance", id = 22727, sell = 30000 },
	{ name = "rift shield", id = 22726, sell = 50000 },
	{ name = "ring of the sky", id = 3006, sell = 30000 },
	{ name = "royal axe", id = 7434, sell = 40000 },
	{ name = "ruby necklace", id = 3016, sell = 2000 },
	{ name = "ruthless axe", id = 6553, sell = 45000 },
	{ name = "sacred tree amulet", id = 9302, sell = 3000 },
	{ name = "sapphire hammer", id = 7437, sell = 7000 },
	{ name = "scarab amulet", id = 3018, sell = 200 },
	{ name = "scarab shield", id = 3440, sell = 2000 },
	{ name = "shockwave amulet", id = 9304, sell = 3000 },
	{ name = "silver brooch", id = 3017, sell = 150 },
	{ name = "silver dagger", id = 3290, sell = 500 },
	{ name = "skull helmet", id = 5741, sell = 40000 },
	{ name = "skullcracker armor", id = 8061, sell = 18000 },
	{ name = "spiked squelcher", id = 7452, sell = 5000 },
	{ name = "steel boots", id = 3554, sell = 30000 },
	{ name = "swamplair armor", id = 8052, sell = 16000 },
	{ name = "taurus mace", id = 7425, sell = 500 },
	{ name = "tempest shield", id = 3442, sell = 35000 },
	{ name = "terra amulet", id = 814, sell = 1500 },
	{ name = "terra boots", id = 813, sell = 2500 },
	{ name = "terra hood", id = 830, sell = 2500 },
	{ name = "terra legs", id = 812, sell = 11000 },
	{ name = "terra mantle", id = 811, sell = 11000 },
	{ name = "the justice seeker", id = 7390, sell = 40000 },
	{ name = "tortoise shield", id = 6131, sell = 150 },
	{ name = "vile axe", id = 7388, sell = 30000 },
	{ name = "voodoo doll", id = 3002, sell = 400 },
	{ name = "war axe", id = 3342, sell = 12000 },
	{ name = "war horn", id = 2958, sell = 8000 },
	{ name = "witch hat", id = 9653, sell = 5000 },
	{ name = "wyvern fang", id = 7408, sell = 1500 }
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
	if not checkExhaustShop(player) then
        return false
    end
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
	if not checkExhaustShop(player) then
        return false
    end
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
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Of course, just browse through my wares. I buy a little of everything.", cid)
	end
	
	if(msgcontains(msg, "mission")) then
		if(os.date("%A") == "Monday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission01) < 1) then
				npcHandler:say("Well, you could attempt the mission to become a recognised trader, but it requires a lot of travelling. Are you willing to try?", cid)
				npcHandler.topic[cid] = 1
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission01) == 1) then
				npcHandler:say("Have you managed to obtain a rare deer trophy for my customer?", cid)
				npcHandler.topic[cid] = 3
			end
		elseif(os.date("%A") == "Tuesday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission01) == 2 and player:getStorageValue(Storage.TravellingTrader.Mission02) < 1 ) then
				npcHandler:say("So, my friend, are you willing to proceed to the next mission to become a recognised trader?", cid)
				npcHandler.topic[cid] = 4
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission02) == 4) then
				npcHandler:say("Did you bring me the package?", cid)
				npcHandler.topic[cid] = 6
			end
		elseif(os.date("%A") == "Wednesday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission02) == 5 and player:getStorageValue(Storage.TravellingTrader.Mission03) < 1 ) then
				npcHandler:say("So, my friend, are you willing to proceed to the next mission to become a recognised trader?", cid)
				npcHandler.topic[cid] = 7
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission03) == 2) then
				npcHandler:say("Have you brought the cheese?", cid)
				npcHandler.topic[cid] = 9
			end
		elseif(os.date("%A") == "Thursday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission03) == 3 and player:getStorageValue(Storage.TravellingTrader.Mission04) < 1) then
				npcHandler:say("So, my friend, are you willing to proceed to the next mission to become a recognised trader?", cid)
				npcHandler.topic[cid] = 10
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission04) == 2) then
				npcHandler:say("Have you brought the vase?", cid)
				npcHandler.topic[cid] = 12
			end
		elseif(os.date("%A") == "Friday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission04) == 3 and player:getStorageValue(Storage.TravellingTrader.Mission05) < 1) then
				npcHandler:say("So, my friend, are you willing to proceed to the next mission to become a recognised trader?", cid)
				npcHandler.topic[cid] = 13
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission05) == 2) then
				npcHandler:say("Have you brought a cheap but good crimson sword?", cid)
				npcHandler.topic[cid] = 15
			end
		elseif(os.date("%A") == "Saturday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission05) == 3 and player:getStorageValue(Storage.TravellingTrader.Mission06) < 1) then
				npcHandler:say("So, my friend, are you willing to proceed to the next mission to become a recognised trader?", cid)
				npcHandler.topic[cid] = 16
			elseif(player:getStorageValue(Storage.TravellingTrader.Mission06) == 1) then
				npcHandler:say("Have you brought me a gold fish??", cid)
				npcHandler.topic[cid] = 18
			end
		elseif(os.date("%A") == "Sunday") then
			if(player:getStorageValue(Storage.TravellingTrader.Mission06) == 2 and player:getStorageValue(Storage.TravellingTrader.Mission07) ~= 1) then
				npcHandler:say("Ah, right. <ahem> I hereby declare you - one of my recognised traders! Feel free to offer me your wares!", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission07, 1)
				player:addAchievement('Recognised Trader')
				npcHandler.topic[cid] = 0
			end
		end
	elseif(msgcontains(msg, "yes")) then
		if(npcHandler.topic[cid] == 1) then
			npcHandler:say({
				"Very good! I need talented people who are able to handle my wares with care, find good offers and the like, so I'm going to test you. ...",
				"First, I'd like to see if you can dig up rare wares. Something like a ... mastermind shield! ...",
				"Haha, just kidding, fooled you there, didn't I? Always control your nerves, that's quite important during bargaining. ...",
				"Okay, all I want from you is one of these rare deer trophies. I have a customer here in Svargrond who ordered one, so I'd like you to deliver it tome while I'm in Svargrond. ...",
				"Everything clear and understood?"
			}, cid)

			npcHandler.topic[cid] = 2
		elseif(npcHandler.topic[cid] == 2) then
			npcHandler:say("Fine. Then get a hold of that deer trophy and bring it to me while I'm in Svargrond. Just ask me about your mission.", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission01, 1)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 3) then
			if player:removeItem(7397, 1) then
				npcHandler:say("Well done! I'll take that from you. <snags it> Come see me another day, I'll be busy for a while now. ", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission01, 2)
				npcHandler.topic[cid] = 0
			end
		elseif(npcHandler.topic[cid] == 4) then
			npcHandler:say({
				"Alright, that's good to hear. From you as my trader and deliveryman, I expect more than finding rare items. ...",
				"You also need to be able to transport heavy wares, weaklings won't get far here. I have ordered a special package from Edron. ...",
				"Pick it up from Willard and bring it back to me while I'm in Liberty Bay. Everything clear and understood?"
			}, cid)
			npcHandler.topic[cid] = 5
		elseif(npcHandler.topic[cid] == 5) then
			npcHandler:say("Fine. Then off you go, just ask Willard about the 'package for Rashid'.", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission02, 1)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 6) then
			if player:removeItem(145, 1) then
				npcHandler:say("Great. Just place it over there - yes, thanks, that's it. Come see me another day, I'll be busy for a while now. ", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission02, 5)
				npcHandler.topic[cid] = 0
			end
		elseif(npcHandler.topic[cid] == 7) then
			npcHandler:say({
				"Well, that's good to hear. From you as my trader and deliveryman, I expect more than carrying heavy packages. ...",
				"You also need to be fast and deliver wares in time. I have ordered a very special cheese wheel made from Darashian milk. ...",
				"Unfortunately, the high temperature in the desert makes it rot really fast, so it must not stay in the sun for too long. ...",
				"I'm also afraid that you might not be able to use ships because of the smell of the cheese. ...",
				"Please get the cheese from Miraia and bring it to me while I'm in Port Hope. Everything clear and understood?"
			}, cid)
			npcHandler.topic[cid] = 8
		elseif(npcHandler.topic[cid] == 8) then
			npcHandler:say("Okay, then please find Miraia in Darashia and ask her about the {'scarab cheese'}.", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission03, 1)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 9) then
			if player:removeItem(169, 1) then
				npcHandler:say("Mmmhh, the lovely odeur of scarab cheese! I really can't understand why most people can't stand it. Thanks, well done! ", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission03, 3)
				npcHandler.topic[cid] = 0
			end
		elseif(npcHandler.topic[cid] == 10) then
			npcHandler:say({
				"Well, that's good to hear. From you as my trader and deliveryman, I expect more than bringing stinky cheese. ...",
				"I wonder if you are able to deliver goods so fragile they almost break when looked at. ...",
				"I have ordered a special elven vase from Briasol in Ab'Dendriel. Get it from him and don't even touch it, just bring it to me while I'm in Ankrahmun. Everything clear and understood?"
			}, cid)
			npcHandler.topic[cid] = 11
		elseif(npcHandler.topic[cid] == 11) then
			npcHandler:say("Okay, then please find {Briasol} in {Ab'Dendriel} and ask for a {'fine vase'}.", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission04, 1)
			player:addMoney(1000)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 12) then
			if player:removeItem(227, 1) then
				npcHandler:say("I'm surprised that you managed to bring this vase without a single crack. That was what I needed to know, thank you. ", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission04, 3)
				npcHandler.topic[cid] = 0
			end
		elseif(npcHandler.topic[cid] == 13) then
			npcHandler:say({
				"Fine! There's one more skill that I need to test and which is cruicial for a successful trader. ...",
				"Of course you must be able to haggle, else you won't survive long in this business. To make things as hard as possible for you, I have the perfect trade partner for you. ...",
				"Dwarves are said to be the most stubborn of all traders. Travel to {Kazordoon} and try to get the smith {Uzgod} to sell a {crimson sword} to you. ...",
				"Of course, it has to be cheap. Don't come back with anything more expensive than 400 gold. ...",
				"And the quality must not suffer, of course! Everything clear and understood?",
				"Dwarves are said to be the most stubborn of all traders. Travel to Kazordoon and try to get the smith Uzgod to sell a crimson sword to you. ..."
			}, cid)
			npcHandler.topic[cid] = 15
		elseif(npcHandler.topic[cid] == 14) then
			npcHandler:say("Okay, I'm curious how you will do with {Uzgod}. Good luck!", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission05, 1)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 15) then
			if player:removeItem(7385, 1) then
				npcHandler:say("Ha! You are clever indeed, well done! I'll take this from you. Come see me tomorrow, I think we two might get into business after all.", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission05, 3)
				npcHandler.topic[cid] = 0
			end
		elseif(npcHandler.topic[cid] == 16) then
			npcHandler:say({
				"My friend, it seems you have already learnt a lot about the art of trading. I think you are more than worthy to become a recognised trader. ...",
				"There is just one little favour that I would ask from you... something personal, actually, forgive my boldness. ...",
				"I have always dreamed to have a small pet, one that I could take with me and which wouldn't cause problems. ...",
				"Could you - just maybe - bring me a small goldfish in a bowl? I know that you would be able to get one, wouldn't you?"
			}, cid)
			npcHandler.topic[cid] = 17
		elseif(npcHandler.topic[cid] == 17) then
			npcHandler:say("Thanks so much! I'll be waiting eagerly for your return then.", cid)
			player:setStorageValue(Storage.TravellingTrader.Mission06, 1)
			npcHandler.topic[cid] = 0
		elseif(npcHandler.topic[cid] == 18) then
			if player:removeItem(5929, 1) then
				npcHandler:say("Thank you!! Ah, this makes my day! I'll take the rest of the day off to get to know this little guy. Come see me tomorrow, if you like.", cid)
				player:setStorageValue(Storage.TravellingTrader.Mission06, 2)
				npcHandler.topic[cid] = 0
			end
		end
	end
	return true
end

keywordHandler:addKeyword({"job"}, StdModule.say, {npcHandler = npcHandler, text = "I am a travelling trader. I don't buy everything, though. And not from everyone, for that matter."})
keywordHandler:addKeyword({"name"}, StdModule.say, {npcHandler = npcHandler, text = "I am Rashid, son of the desert."})
keywordHandler:addKeyword({"offers"}, StdModule.say, {npcHandler = npcHandler, text = "Of course, old friend. You can also browse only armor, legs, shields, helmets, boots, weapons, enchanted weapons, jewelry or miscellaneous stuff."})
keywordHandler:addKeyword({"ab'dendriel"}, StdModule.say, {npcHandler = npcHandler, text = "Elves... I don't really trust them. All this talk about nature and flowers and treehugging... I'm sure there's some wicked scheme behind all this."})
keywordHandler:addKeyword({"desert"}, StdModule.say, {npcHandler = npcHandler, text = "My beloved hometown! Ah, the sweet scent of the desert sands, the perfect shape of the pyramids... stunningly beautiful."})
keywordHandler:addKeyword({"carlin"}, StdModule.say, {npcHandler = npcHandler, text = "I have to go to Carlin once in a while, since the queen wishes to see my exclusive wares in regular intervals."})
keywordHandler:addKeyword({"cormaya"}, StdModule.say, {npcHandler = npcHandler, text = "Cormaya? Not a good place to make business, it's way too far and small."})
keywordHandler:addKeyword({"darashia"}, StdModule.say, {npcHandler = npcHandler, text = "It's not the real thing, but almost as good. The merchants there claim ridiculous prices, which is fine for my own business."})
keywordHandler:addKeyword({"edron"}, StdModule.say, {npcHandler = npcHandler, text = "Ah yes, Edron! Such a lovely and quiet island! I usually make some nice business there."})
keywordHandler:addKeyword({"fibula"}, StdModule.say, {npcHandler = npcHandler, text = "Too few customers there, it's not worth the trip."})
keywordHandler:addKeyword({"greenshore"}, StdModule.say, {npcHandler = npcHandler, text = "Um... I don't think so."})
keywordHandler:addKeyword({"kazordoon"}, StdModule.say, {npcHandler = npcHandler, text = "I don't like being underground much. I also tend to get lost in these labyrinthine dwarven tunnels, so I rather avoid them."})
keywordHandler:addKeyword({"liberty bay"}, StdModule.say, {npcHandler = npcHandler, text = "When you avoid the slums, it's a really pretty city. Almost as pretty as the governor's daughter."})
keywordHandler:addKeyword({"northport"}, StdModule.say, {npcHandler = npcHandler, text = "Um... I don't think so."})
keywordHandler:addKeyword({"port hope"}, StdModule.say, {npcHandler = npcHandler, text = "I like the settlement itself, but I don't set my foot into the jungle. Have you seen the size of these centipedes??"})
keywordHandler:addKeyword({"senja"}, StdModule.say, {npcHandler = npcHandler, text = "Um... I don't think so."})
keywordHandler:addKeyword({"svargrond"}, StdModule.say, {npcHandler = npcHandler, text = "I wish it was a little bit warmer there, but with a good mug of barbarian mead in your tummy everything gets a lot cosier."})
keywordHandler:addKeyword({"thais"}, StdModule.say, {npcHandler = npcHandler, text = "I feel uncomfortable and rather unsafe in Thais, so I don't really travel there."})
keywordHandler:addKeyword({"vega"}, StdModule.say, {npcHandler = npcHandler, text = "Um... I don't think so."})
keywordHandler:addKeyword({"venore"}, StdModule.say, {npcHandler = npcHandler, text = "Although it's the flourishing trade centre of Tibia, I don't like going there. Too much competition for my taste."})
keywordHandler:addKeyword({"time"}, StdModule.say, {npcHandler = npcHandler, text = "It's almost time to journey on."})
keywordHandler:addKeyword({"king"}, StdModule.say, {npcHandler = npcHandler, text = "Kings, queens, emperors and kaliphs... everyone claims to be different and unique, but actually it's the same thing everywhere."})

npcHandler:setMessage(MESSAGE_GREET, "Ah, a customer! Be greeted, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, |PLAYERNAME|, may the winds guide your way.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Come back soon!")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Take all the time you need to decide what you want!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
