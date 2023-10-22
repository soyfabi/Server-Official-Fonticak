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
	{ name = "atlas", id = 6108, buy = 150 },
	{ name = "first verse of the hymn", id = 6087, sell = 100 },
	{ name = "fourth verse of the hymn", id = 6090, sell = 800 },
	{ name = "orichalcum pearl", id = 5021, buy = 80 },
	{ name = "second verse of the hymn", id = 6088, sell = 250 },
	{ name = "third verse of the hymn", id = 6089, sell = 400 }
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
		npcHandler:say("Of course, just browse through my wares. Or do you want to look only at {potions}, {wands} or {runes}?", cid)
	end

	if msgcontains(msg, "mission") then
		if player:getStorageValue(Storage.ExplorerSociety.CalassaQuest) == 2 then
			npcHandler:say("OH! So you have safely returned from Calassa! Congratulations, were you able to retrieve the logbook?", cid)
			npcHandler.topic[cid] = 5
		elseif player:getStorageValue(Storage.ExplorerSociety.TheOrcPowder) > 34 and player:getStorageValue(Storage.ExplorerSociety.QuestLine) > 34 then
			npcHandler:say("The most important mission we currently have is an expedition to {Calassa}.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "calassa") then
		if npcHandler.topic[cid] == 1 and player:getStorageValue(Storage.ExplorerSociety.CalassaQuest) < 1 then
			npcHandler:say("Ah! So you have heard about our special mission to investigate the Quara race in their natural surrounding! Would you like to know more about it?", cid)
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 4 then
			npcHandler:say("Captain Max will bring you to Calassa whenever you are ready. Please try to retrieve the missing logbook which must be in one of the sunken shipwrecks.", cid)
			player:setStorageValue(Storage.ExplorerSociety.CalassaDoor, 1)
			player:setStorageValue(Storage.ExplorerSociety.CalassaQuest, 1)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.ExplorerSociety.CalassaQuest) == 2 then
			npcHandler:say("OH! So you have safely returned from Calassa! Congratulations, were you able to retrieve the logbook?", cid)
			npcHandler.topic[cid] = 5
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Since you have already proved to be a valuable member of our society, I will happily entrust you with this mission, but there are a few things which you need to know, so listen carefully. ...",
				"Calassa is an underwater settlement, so you are in severe danger of drowning unless you are well-prepared. ...",
				"We have developed a new device called 'Helmet of the Deep' which will enable you to breathe even in the depths of the ocean. ...",
				"I will instruct Captain Max to bring you to Calassa and to lend one of these helmets to you. These helmets are very valuable, so there is a deposit of 5000 gold pieces on it. ...",
				"While in Calassa, do not take the helmet off under any circumstances. If you have any questions, don't hesitate to ask Captain Max. ...",
				"Your mission there, apart from observing the Quara, is to retrieve a special logbook from one of the shipwrecks buried there. ...",
				"One of our last expeditions there failed horribly and the ship sank, but we still do not know the exact reason. ...",
				"If you could retrieve the logbook, we'd finally know what happened. Have you understood your task and are willing to take this risk?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Excellent! I will immediately inform Captain Max to bring you to {Calassa} whenever you are ready. Don't forget to make thorough preparations!", cid)
			npcHandler.topic[cid] = 4
			player:setStorageValue(Storage.ExplorerSociety.CalassaQuest, 1)
			player:setStorageValue(Storage.ExplorerSociety.CalassaDoor, 1)
		elseif npcHandler.topic[cid] == 5 then
			if player:removeItem(21378, 1) then
				player:setStorageValue(Storage.ExplorerSociety.CalassaQuest, 3)
				npcHandler:say("Yes! That's the logbook! However... it seems that the water has already destroyed many of the pages. This is not your fault though, you did your best. Thank you!", cid)
				npcHandler.topic[cid] = 0
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
