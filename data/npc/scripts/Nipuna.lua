 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "avalanche rune", id = 3161, buy = 57 },
	{ name = "blank rune", id = 3147, buy = 10 },
	{ name = "chameleon rune", id = 3178, buy = 210 },
	{ name = "convince creature rune", id = 3177, buy = 80 },
	{ name = "cure poison rune", id = 3153, buy = 65 },
	{ name = "destroy field rune", id = 3148, buy = 15 },
	{ name = "dragonfruit", id = 11682, buy = 5 },
	{ name = "egg", id = 3606, buy = 3 },
	{ name = "empty potion flask", id = 283, sell = 5 },
	{ name = "empty potion flask", id = 284, sell = 5 },
	{ name = "empty potion flask", id = 285, sell = 5 },
	{ name = "energy field rune", id = 3164, buy = 38 },
	{ name = "energy wall rune", id = 3166, buy = 85 },
	{ name = "explosion rune", id = 3200, buy = 31 },
	{ name = "fire bomb rune", id = 3192, buy = 147 },
	{ name = "fire field rune", id = 3188, buy = 28 },
	{ name = "fire wall rune", id = 3190, buy = 61 },
	{ name = "great fireball rune", id = 3191, buy = 57 },
	{ name = "great health potion", id = 239, buy = 225 },
	{ name = "great mana potion", id = 238, buy = 144 },
	{ name = "great spirit potion", id = 7642, buy = 228 },
	{ name = "health potion", id = 266, buy = 50 },
	{ name = "heavy magic missile rune", id = 3198, buy = 12 },
	{ name = "intense healing rune", id = 3152, buy = 95 },
	{ name = "light magic missile rune", id = 3174, buy = 4 },
	{ name = "mana potion", id = 268, buy = 56 },
	{ name = "poison field rune", id = 3172, buy = 21 },
	{ name = "poison wall rune", id = 3176, buy = 52 },
	{ name = "stalagmite rune", id = 3179, buy = 12 },
	{ name = "strong health potion", id = 236, buy = 115 },
	{ name = "strong mana potion", id = 237, buy = 93 },
	{ name = "sudden death rune", id = 3155, buy = 135 },
	{ name = "supreme health potion", id = 23375, buy = 625 },
	{ name = "ultimate healing rune", id = 3160, buy = 175 },
	{ name = "ultimate health potion", id = 7643, buy = 379 },
	{ name = "ultimate mana potion", id = 23373, buy = 438 },
	{ name = "ultimate spirit potion", id = 23374, buy = 438 },
	{ name = "vial", id = 2874, sell = 5 }
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
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Keep in mind you won't find better offers here. Just browse through my wares.", cid)
	end

	local player = Player(cid)
	if msgcontains(msg, 'adorn')
			or msgcontains(msg, 'outfit')
			or msgcontains(msg, 'addon') then
		local addonProgress = player:getStorageValue(Storage.OutfitQuest.Knight.AddonHelmet)
		if addonProgress == 5 then
			player:setStorageValue(Storage.OutfitQuest.Knight.MissionHelmet, 6)
			player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmet, 6)
			player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmetTimer, os.time() + 7200)
			npcHandler:say('Oh, Gregor sent you? I see. It will be my pleasure to adorn your helmet. Please give me some time to finish it.', cid)
		elseif addonProgress == 6 then
			if player:getStorageValue(Storage.OutfitQuest.Knight.AddonHelmetTimer) < os.time() then
				player:setStorageValue(Storage.OutfitQuest.Knight.MissionHelmet, 0)
				player:setStorageValue(Storage.OutfitQuest.Knight.AddonHelmet, 7)
				player:setStorageValue(Storage.OutfitQuest.Ref, math.min(0, player:getStorageValue(Storage.OutfitQuest.Ref) - 1))
				player:addOutfitAddon(131, 2)
				player:addOutfitAddon(139, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				npcHandler:say('Just in time, |PLAYERNAME|. Your helmet is finished, I hope you like it.', cid)
			else
				npcHandler:say('Please have some patience, |PLAYERNAME|. Forging is hard work!', cid)
			end
		elseif addonProgress == 7 then
			npcHandler:say('I think it\'s one of my masterpieces.', cid)
		else
			npcHandler:say('Sorry, but without the permission of Gregor I cannot help you with this matter.', cid)
		end

	elseif msgcontains(msg, "old backpack") or msgcontains(msg, "backpack") then
		if player:getStorageValue(Storage.SamsOldBackpack) < 1 then
			npcHandler:say("What? Are you telling me you found my old adventurer's backpack that I lost years ago??", cid)
			npcHandler.topic[cid] = 1
		end

	elseif msgcontains(msg, '2000 steel shields') then
		if player:getStorageValue(Storage.WhatAFoolishQuest.Questline) ~= 29
				or player:getStorageValue(Storage.WhatAFoolishQuest.Contract) == 2 then
			npcHandler:say('My offers are weapons, armors, helmets, legs, and shields. If you\'d like to see my offers, ask me for a {trade}.', cid)
			return true
		end

		npcHandler:say('What? You want to buy 2000 steel shields??', cid)
		npcHandler.topic[cid] = 2

	elseif msgcontains(msg, 'contract') then
		if player:getStorageValue(Storage.WhatAFoolishQuest.Contract) == 0 then
			npcHandler:say('Have you signed the contract?', cid)
			npcHandler.topic[cid] = 4
		end

	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			if player:removeItem(3244, 1) then
				npcHandler:say({
					"Thank you very much! This brings back good old memories! Please, as a reward, travel to Kazordoon and ask my old friend Kroox to provide you a special dwarven armor. ...",
					"I will mail him about you immediately. Just tell him, his old buddy Sam is sending you."
				}, cid)
				player:setStorageValue(Storage.SamsOldBackpack, 1)
				player:addAchievement('Backpack Tourist')
			else
				npcHandler:say("You don't have it...", cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say('I can\'t believe it. Finally I will be rich! I could move to Edron and enjoy my retirement! But ... wait a minute! I will not start working without a contract! Are you willing to sign one?', cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			player:addItem(129, 1)
			player:setStorageValue(Storage.WhatAFoolishQuest.Contract, 1)
			npcHandler:say('Fine! Here is the contract. Please sign it. Talk to me about it again when you\'re done.', cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 4 then
			if not player:removeItem(128, 1) then
				npcHandler:say('You don\'t have a signed contract.', cid)
				npcHandler.topic[cid] = 0
				return true
			end

			player:setStorageValue(Storage.WhatAFoolishQuest.Contract, 2)
			npcHandler:say('Excellent! I will start working right away! Now that I am going to be rich, I will take the opportunity to tell some people what I REALLY think about them!', cid)
			npcHandler.topic[cid] = 0
		end

	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("Then no.", cid)
		elseif isInArray({2, 3, 4}, npcHandler.topic[cid]) then
			npcHandler:say("This deal sounded too good to be true anyway.", cid)
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I am the blacksmith. If you need weapons or armor - just ask me."})

npcHandler:setMessage(MESSAGE_GREET, "Welcome to my shop, adventurer |PLAYERNAME|! I {trade} with weapons and armor.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye and come again, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye and come again.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
