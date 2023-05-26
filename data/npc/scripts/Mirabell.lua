local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'The Horn of Plenty is always open for tired adventurers.'} }
npcHandler:addModule(VoiceModule:new(voices))

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "bread", id = 3600, buy = 4 },
	{ name = "cheese", id = 3607, buy = 6 },
	{ name = "ham", id = 3582, buy = 8 },
	{ name = "meat", id = 3577, buy = 5 },
	{ name = "mug of beer", id = 2880, buy = 2, count = 3 },
	{ name = "mug of lemonade", id = 2880, buy = 2, count = 12 },
	{ name = "mug of water", id = 2880, buy = 1, count = 1 },
	{ name = "mug of wine", id = 2880, buy = 3, count = 2 }
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
	
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Keep in mind you won't find better offers here. Just browse through my wares.", cid)
	end

	local player = Player(cid)

	if msgcontains(msg, 'pies') then
		if player:getStorageValue(Storage.WhatAFoolish.PieBuying) == -1 then
			npcHandler:say('Oh you\'ve heard about my excellent pies, didn\'t you? I am flattered. Unfortunately I\'m completely out of flour. I need 2 portions of flour for one pie. Just tell me when you have enough flour for your pies.', cid)
			return true
		end

		npcHandler:say('For 12 pies this is 240 gold. Do you want to buy them?', cid)
		npcHandler.topic[cid] = 2
	elseif msgcontains(msg, 'flour') then
		npcHandler:say('Do you bring me the flour needed for your pies?', cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			if not player:removeItem(3603, 24) then
				npcHandler:say('I think you are confusing the dust in your pockets with flour. You certainly do not have enough flour for 12 pies.', cid)
				npcHandler.topic[cid] = 0
				return true
			end

			player:setStorageValue(Storage.WhatAFoolish.PieBuying, player:getStorageValue(Storage.WhatAFoolish.PieBuying) + 1)
			npcHandler:say('Excellent. Now I can start baking the pies. As you helped me, I will make you a good price for them.', cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			if not player:removeMoneyNpc(240) then
				npcHandler:say('You don\'t have enough money, don\'t try to fool me.', cid)
				npcHandler.topic[cid] = 0
				return true
			end

			player:addItem(119, 1)
			player:setStorageValue(Storage.WhatAFoolish.PieBuying, player:getStorageValue(Storage.WhatAFoolish.PieBuying) - 1)
			player:setStorageValue(Storage.WhatAFoolish.PieBoxTimer, os.time() + 1200) -- 20 minutes to deliver
			npcHandler:say({
				'Here they are. Wait! Two things you should know: Firstly, they won\'t last long in the sun so you better get them to their destination as quickly as possible ...',
				'Secondly, since my pies are that delicious it is forbidden to leave the town with them. We can\'t afford to attract more tourists to Edron.'
			}, cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, 'no') then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say('Without flour I can\'t do anything, sorry.', cid)
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say('What are you? Some kind of fool?', cid)
		end
		npcHandler.topic[cid] = 0
	end

	return true
end

keywordHandler:addKeyword({'drink'}, StdModule.say, {npcHandler = npcHandler, text = 'I can offer you beer, wine, lemonade and water. If you\'d like to see my offers, ask me for a {trade}.'})
keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, text = 'Are you looking for food? I have bread, cheese, ham, and meat. If you\'d like to see my offers, ask me for a {trade}.'})

npcHandler:setMessage(MESSAGE_GREET, "Welcome to the Horn of Plenty, |PLAYERNAME|. Sit down, have a {drink} or some {food}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Come back soon, traveller.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Come back soon, traveller.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, take a look at my tasty offers.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
