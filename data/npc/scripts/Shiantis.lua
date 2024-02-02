local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Containers, decoration and general goods, all here!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "brown book", id = 2837, buy = 15 },
	{ name = "bucket", id = 2873, buy = 4 },
	{ name = "candelabrum", id = 2911, buy = 8 },
	{ name = "candlestick", id = 2917, buy = 2 },
	{ name = "chimney kit", id = 7864, buy = 200 },
	{ name = "closed trap", id = 3481, buy = 280, sell = 75 },
	{ name = "coal basin kit", id = 2806, buy = 25 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "cuckoo clock", id = 2664, buy = 40 },
	{ name = "document", id = 2834, buy = 12 },
	{ name = "empty goldfish bowl", id = 5928, buy = 50 },
	{ name = "fishing rod", id = 3483, buy = 150, sell = 40 },
	{ name = "gemmed book", id = 2842, sell = 100 },
	{ name = "globe kit", id = 2797, buy = 50 },
	{ name = "green book", id = 2846, sell = 15 },
	{ name = "greeting card", id = 6386, buy = 30 },
	{ name = "grey small book", id = 2839, buy = 15 },
	{ name = "hand auger", id = 31334, buy = 25 },
	{ name = "inkwell", id = 3509, buy = 10, sell = 8 },
	{ name = "machete", id = 3308, buy = 35, sell = 6 },
	{ name = "net", id = 31489, buy = 50 },
	{ name = "orange book", id = 2843, sell = 30 },
	{ name = "oven kit", id = 6371, buy = 80 },
	{ name = "parchment", id = 2817, buy = 8 },
	{ name = "pendulum clock kit", id = 2801, buy = 75 },
	{ name = "pick", id = 3456, sell = 15 },
	{ name = "picture", id = 2639, buy = 50 },
	{ name = "picture", id = 2640, buy = 50 },
	{ name = "picture", id = 2641, buy = 50 },
	{ name = "present", id = 2856, buy = 10 },
	{ name = "red backpack", id = 2867, buy = 20 },
	{ name = "red bag", id = 2859, buy = 5 },
	{ name = "rocking horse kit", id = 2800, buy = 30 },
	{ name = "rope", id = 3003, buy = 50, sell = 15 },
	{ name = "scroll", id = 2815, buy = 5 },
	{ name = "scythe", id = 3453, buy = 50, sell = 10 },
	{ name = "shovel", id = 3457, buy = 50, sell = 8 },
	{ name = "table lamp kit", id = 2798, buy = 35 },
	{ name = "telescope kit", id = 2799, buy = 70 },
	{ name = "torch", id = 2920, buy = 2 },
	{ name = "valentine's card", id = 6538, buy = 30 },
	{ name = "vial", id = 2874, sell = 5 },
	{ name = "vial of oil", id = 2874, buy = 20, count = 7 },
	{ name = "wall mirror", id = 2638, buy = 40 },
	{ name = "watch", id = 6092, buy = 20 },
	{ name = "water pipe", id = 2974, buy = 40 },
	{ name = "wooden hammer", id = 3459, sell = 15 },
	{ name = "worm", id = 3492, buy = 1 }
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
		npcHandler:say("I sell misdeeds, monuments, cards, pipes, even a football.", cid)
	end
	if msgcontains(msg, "football") then
		npcHandler:say("Do you want to buy a football for 111 gold?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			local player = Player(cid)
			if player:getMoney() + player:getBankBalance() >= 111 then
				npcHandler:say("Here it is.", cid)
				player:addItem(2990, 1)
				player:removeMoneyNpc(111)
			else
				npcHandler:say("You don't have enough money.", cid)
			end
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Oh, please come in, |PLAYERNAME|. What can I do for you? If you need adventure equipment, ask me for a {trade}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, just browse through my wares.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
