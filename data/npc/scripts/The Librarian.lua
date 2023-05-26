local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)
npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
npcHandler:onThink()
end

local playerTopic = {}
local function greetCallback(cid)
	local player = Player(cid)
	if player:getStorageValue(Storage.KilmareshQuest.First.Acesso) < 1 then
		npcHandler:setMessage(MESSAGE_GREET, "How could I help you?") -- It needs to be revised, it's not the same as the global
		playerTopic[cid] = 1
	elseif (player:getStorageValue(Storage.KilmareshQuest.First.jamesfrancisTask) >= 0 and player:getStorageValue(Storage.KilmareshQuest.First.jamesfrancisTask) <= 50)
	and player:getStorageValue(Storage.KilmareshQuest.First.Mission) < 3 then
		npcHandler:setMessage(MESSAGE_GREET, "How could I help you?") -- It needs to be revised, it's not the same as the global
		playerTopic[cid] = 15
	elseif player:getStorageValue(Storage.KilmareshQuest.First.Mission) == 4 then
		npcHandler:setMessage(MESSAGE_GREET, "How could I help you?") -- It needs to be revised, it's not the same as the global
		player:setStorageValue(Storage.KilmareshQuest.First.Mission, 5)
		playerTopic[cid] = 20
	end
	npcHandler:addFocus(cid)
	return true
end

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "Inkwell black", id = 28568, sell = 720 },
	{ name = "atlas", id = 6108, buy = 150 },
	{ name = "black book", id = 2838, buy = 20 },
	{ name = "blue book", id = 2844, sell = 40 },
	{ name = "book page", id = 28569, sell = 640 },
	{ name = "brown book", id = 2837, buy = 20 },
	{ name = "bunch of reed", id = 30975, sell = 25 },
	{ name = "document", id = 2834, buy = 20 },
	{ name = "gemmed book", id = 2842, sell = 150 },
	{ name = "glowing rune", id = 28570, sell = 350 },
	{ name = "green book", id = 2831, sell = 30 },
	{ name = "greeting card", id = 6386, buy = 40 },
	{ name = "grey small book", id = 2839, buy = 20 },
	{ name = "inkwell", id = 3509, buy = 20, sell = 15 },
	{ name = "orange book", id = 2843, sell = 60 },
	{ name = "parchment", id = 2833, buy = 15, sell = 10 },
	{ name = "parchment", id = 2835, buy = 15 },
	{ name = "quill", id = 28567, sell = 1100 },
	{ name = "scroll", id = 2815, buy = 10 },
	{ name = "silken bookmark", id = 28566, sell = 1300 },
	{ name = "valentine's card", id = 6538, buy = 40 }
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
npcHandler.topic[cid] = playerTopic[cid]
local player = Player(cid)
if msgcontains(msg, "ring") and player:getStorageValue(Storage.KilmareshQuest.Fourth.Moe) == 4 then
	if player:getStorageValue(Storage.KilmareshQuest.Fourth.Moe) == 4 then
		player:setStorageValue(Storage.KilmareshQuest.Fifth.Memories, 1)
		player:setStorageValue(Storage.KilmareshQuest.Fourth.Moe, 5)
		npcHandler:say({"To extract memories from the ring, you have to enter a trance-like state with the help of a hallucinogen. Like this you can see all memories that are stored in the ring. Ask Faloriel for a respective potion."}, cid)
		npcHandler:say({"Drink it while wearing the ring in the Temple of Bastesh and say: ,Sa Katesa Tarsani na. If the legends are true you will be able to take memories with you in the form of memory shards."}, cid)
		npcHandler.topic[cid] = 1
		playerTopic[cid] = 1
	else
		npcHandler:say({"Sorry."}, cid)
	end	
end
return true
end

npcHandler:setMessage(MESSAGE_WALKAWAY, 'Well, bye then.')
npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
