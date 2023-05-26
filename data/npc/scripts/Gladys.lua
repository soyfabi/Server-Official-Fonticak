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
	{ name = "badger boots", id = 22086, sell = 7500 },
	{ name = "basket", id = 2855, buy = 6 },
	{ name = "bottle", id = 2875, buy = 3 },
	{ name = "bucket", id = 2873, buy = 4 },
	{ name = "candelabrum", id = 2911, buy = 8 },
	{ name = "candlestick", id = 2917, buy = 2 },
	{ name = "closed trap", id = 3481, buy = 280, sell = 75 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "fishing rod", id = 3483, buy = 150, sell = 40 },
	{ name = "fox paw", id = 27462, sell = 100 },
	{ name = "fur armor", id = 22085, sell = 5000 },
	{ name = "hand auger", id = 31334, buy = 25 },
	{ name = "machete", id = 3308, buy = 35, sell = 6 },
	{ name = "net", id = 31489, buy = 50 },
	{ name = "pick", id = 3456, buy = 50, sell = 15 },
	{ name = "present", id = 2856, buy = 10 },
	{ name = "rope", id = 3003, buy = 50, sell = 15 },
	{ name = "scythe", id = 3453, buy = 50, sell = 10 },
	{ name = "shovel", id = 3457, buy = 50, sell = 8 },
	{ name = "torch", id = 2920, buy = 2 },
	{ name = "watch", id = 2906, buy = 20, sell = 6 },
	{ name = "werebadger claws", id = 22051, sell = 160 },
	{ name = "werebadger skull", id = 22055, sell = 185 },
	{ name = "werebear fur", id = 22057, sell = 185 },
	{ name = "werebear skull", id = 22057, sell = 195 },
	{ name = "wereboar hooves", id = 22053, sell = 175 },
	{ name = "wereboar loincloth", id = 22087, sell = 1500 },
	{ name = "wereboar tusk", id = 22054, sell = 165 },
	{ name = "werefox tail", id = 27463, sell = 200 },
	{ name = "werewolf amulet", id = 22060, sell = 3000 },
	{ name = "werewolf fang", id = 22052, sell = 180 },
	{ name = "werewolf fur", id = 10317, sell = 380 },
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
	local player = Player(cid)
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Keep in mind you won't find better offers here. Just browse through my wares.", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
