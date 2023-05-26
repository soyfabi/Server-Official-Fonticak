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
	{ name = "amphora", id = 2893, buy = 4 },
	{ name = "armor rack kit", id = 6114, buy = 90 },
	{ name = "barrel kit", id = 2793, buy = 12 },
	{ name = "big table kit", id = 2785, buy = 30 },
	{ name = "birdcage kit", id = 2796, buy = 50 },
	{ name = "blue bed kit", id = 834, buy = 80 },
	{ name = "blue pillow", id = 2394, buy = 25 },
	{ name = "blue tapestry", id = 2659, buy = 25 },
	{ name = "bookcase kit", id = 6372, buy = 70 },
	{ name = "box", id = 2469, buy = 10 },
	{ name = "canopy bed kit", id = 17972, buy = 200 },
	{ name = "chest", id = 2472, buy = 10 },
	{ name = "chimney kit", id = 7864, buy = 200 },
	{ name = "coal basin kit", id = 2806, buy = 25 },
	{ name = "crate", id = 2471, buy = 10 },
	{ name = "cuckoo clock", id = 2664, buy = 40 },
	{ name = "drawer kit", id = 2789, buy = 18 },
	{ name = "dresser kit", id = 2790, buy = 25 },
	{ name = "empty goldfish bowl", id = 5928, buy = 50 },
	{ name = "flower bowl", id = 2983, buy = 6 },
	{ name = "globe kit", id = 2800, buy = 50 },
	{ name = "goblin statue kit", id = 2804, buy = 50 },
	{ name = "god flowers", id = 2981, buy = 5 },
	{ name = "green bed kit", id = 831, buy = 80 },
	{ name = "green cushioned chair kit", id = 2776, buy = 40 },
	{ name = "green pillow", id = 2396, buy = 25 },
	{ name = "green tapestry", id = 2647, buy = 25 },
	{ name = "harp kit", id = 2808, buy = 50 },
	{ name = "heart pillow", id = 2393, buy = 30 },
	{ name = "honey flower", id = 2984, buy = 5 },
	{ name = "indoor plant kit", id = 2811, buy = 8 },
	{ name = "knight statue kit", id = 2802, buy = 50 },
	{ name = "large amphora kit", id = 2805, buy = 50 },
	{ name = "locker kit", id = 2791, buy = 30 },
	{ name = "minotaur statue kit", id = 2803, buy = 50 },
	{ name = "orange tapestry", id = 2653, buy = 25 },
	{ name = "oven kit", id = 6371, buy = 80 },
	{ name = "pendulum clock kit", id = 2801, buy = 75 },
	{ name = "piano kit", id = 2807, buy = 200 },
	{ name = "picture", id = 2639, buy = 50 },
	{ name = "picture", id = 2640, buy = 50 },
	{ name = "picture", id = 2641, buy = 50 },
	{ name = "potted flower", id = 2985, buy = 5 },
	{ name = "purple tapestry", id = 2644, buy = 25 },
	{ name = "red bed kit", id = 833, buy = 80 },
	{ name = "red cushioned chair kit", id = 2775, buy = 40 },
	{ name = "red pillow", id = 2395, buy = 25 },
	{ name = "red tapestry", id = 2656, buy = 25 },
	{ name = "rocking chair kit", id = 2778, buy = 25 },
	{ name = "rocking horse kit", id = 2800, buy = 30 },
	{ name = "round blue pillow", id = 2398, buy = 25 },
	{ name = "round purple pillow", id = 2400, buy = 25 },
	{ name = "round red pillow", id = 2399, buy = 25 },
	{ name = "round table kit", id = 2783, buy = 25 },
	{ name = "round turquoise pillow", id = 2401, buy = 25 },
	{ name = "small blue pillow", id = 2389, buy = 20 },
	{ name = "small green pillow", id = 2387, buy = 20 },
	{ name = "small orange pillow", id = 2390, buy = 20 },
	{ name = "small purple pillow", id = 2386, buy = 20 },
	{ name = "small red pillow", id = 2388, buy = 20 },
	{ name = "small table kit", id = 2782, buy = 20 },
	{ name = "small turquoise pillow", id = 2391, buy = 20 },
	{ name = "small white pillow", id = 2392, buy = 20 },
	{ name = "sofa chair kit", id = 2779, buy = 55 },
	{ name = "square table kit", id = 2784, buy = 25 },
	{ name = "table lamp kit", id = 2798, buy = 35 },
	{ name = "telescope kit", id = 2799, buy = 70 },
	{ name = "treasure chest", id = 2478, buy = 1000 },
	{ name = "trophy stand", id = 872, buy = 50 },
	{ name = "trough kit", id = 2792, buy = 7 },
	{ name = "trunk kit", id = 2794, buy = 10 },
	{ name = "vase", id = 2876, buy = 3 },
	{ name = "venorean cabinet kit", id = 17974, buy = 90 },
	{ name = "venorean drawer kit", id = 17977, buy = 40 },
	{ name = "venorean wardrobe kit", id = 17975, buy = 50 },
	{ name = "wall mirror", id = 2638, buy = 40 },
	{ name = "water pipe", id = 2980, buy = 40 },
	{ name = "weapon rack kit", id = 6115, buy = 90 },
	{ name = "white tapestry", id = 2667, buy = 25 },
	{ name = "wooden chair kit", id = 2777, buy = 15 },
	{ name = "yellow bed kit", id = 832, buy = 80 },
	{ name = "yellow pillow", id = 900, buy = 25 },
	{ name = "yellow tapestry", id = 2650, buy = 25 }
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
