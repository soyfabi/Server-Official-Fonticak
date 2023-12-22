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
	{ name = "basket", id = 2855, buy = 6 },
	{ name = "bottle", id = 2875, buy = 3 },
	{ name = "bucket", id = 2873, buy = 4 },
	{ name = "candelabrum", id = 2911, buy = 8 },
	{ name = "candlestick", id = 2917, buy = 2 },
	{ name = "closed trap", id = 3481, buy = 280, sell = 75 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "cup", id = 2881, buy = 2 },
	{ name = "document", id = 2818, buy = 12 },
	{ name = "fishing rod", id = 3483, buy = 150, sell = 40 },
	{ name = "green backpack", id = 2865, buy = 20 },
	{ name = "green bag", id = 2857, buy = 4 },
	{ name = "hand auger", id = 31334, buy = 25 },
	{ name = "machete", id = 3308, buy = 35, sell = 6 },
	{ name = "net", id = 31489, buy = 50 },
	{ name = "parchment", id = 2817, buy = 8 },
	{ name = "pick", id = 3456, buy = 50, sell = 15 },
	{ name = "plate", id = 2905, buy = 6 },
	{ name = "present", id = 2856, buy = 10 },
	{ name = "rope", id = 3003, buy = 50, sell = 15 },
	{ name = "scroll", id = 2815, buy = 5 },
	{ name = "scythe", id = 3453, buy = 50, sell = 10 },
	{ name = "shovel", id = 3457, buy = 50, sell = 8 },
	{ name = "torch", id = 2920, buy = 2 },
	{ name = "vial", id = 2874, sell = 5 },
	{ name = "vial of oil", id = 2874, buy = 20, count = 7 },
	{ name = "watch", id = 2906, buy = 20, sell = 6 },
	{ name = "waterskin of water", id = 2901, buy = 10, count = 1 },
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
		npcHandler:say("Of course, just browse through my wares. Or do you want to look only at {tools}?", cid)
	end
	return true
end

keywordHandler:addGreetKeyword({"ashari"}, {npcHandler = npcHandler, text = "Greetings, |PLAYERNAME|."})
--Farewell message
keywordHandler:addFarewellKeyword({"asgha thrazi"}, {npcHandler = npcHandler, text = "Good bye, |PLAYERNAME|."})

npcHandler:setMessage(MESSAGE_GREET, "Welcome, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good Bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "May God show you the path, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, just browse through my offers.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
