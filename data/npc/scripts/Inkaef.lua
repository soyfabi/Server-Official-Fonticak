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
	{ name = "armor rack", id = 6114, buy = 90 },
	{ name = "barrel", id = 2793, buy = 12 },
	{ name = "big table", id = 2785, buy = 30 },
	{ name = "birdcage", id = 2796, buy = 50 },
	{ name = "bookcase", id = 6372, buy = 70 },
	{ name = "box", id = 2469, buy = 10 },
	{ name = "chest", id = 2472, buy = 10 },
	{ name = "chest of drawers", id = 2789, buy = 18 },
	{ name = "chimney", id = 7864, buy = 200 },
	{ name = "crate", id = 2471, buy = 10 },
	{ name = "cuckoo clock", id = 2664, buy = 40 },
	{ name = "dresser", id = 2790, buy = 25 },
	{ name = "empty goldfish bowl", id = 5928, buy = 50 },
	{ name = "flower bowl", id = 2983, buy = 6 },
	{ name = "globe", id = 2797, buy = 50 },
	{ name = "goblin statue", id = 2804, buy = 50 },
	{ name = "god flowers", id = 2981, buy = 5 },
	{ name = "green cushioned chair", id = 2775, buy = 40 },
	{ name = "green pillow", id = 2396, buy = 25 },
	{ name = "green tapestry", id = 2647, buy = 25 },
	{ name = "harp", id = 2808, buy = 50 },
	{ name = "heart pillow", id = 2393, buy = 30 },
	{ name = "honey flower", id = 2984, buy = 5 },
	{ name = "indoor plant", id = 2811, buy = 8 },
	{ name = "knight statue", id = 2802, buy = 50 },
	{ name = "large amphora", id = 2805, buy = 50 },
	{ name = "large trunk", id = 2794, buy = 10 },
	{ name = "locker", id = 2791, buy = 30 },
	{ name = "minotaur statue", id = 2803, buy = 50 },
	{ name = "orange tapestry", id = 2653, buy = 25 },
	{ name = "oven", id = 6371, buy = 80 },
	{ name = "pendulum clock", id = 2801, buy = 75 },
	{ name = "piano", id = 2807, buy = 200 },
	{ name = "picture", id = 2639, buy = 50 },
	{ name = "picture", id = 2640, buy = 50 },
	{ name = "picture", id = 2641, buy = 50 },
	{ name = "potted flower", id = 2985, buy = 5 },
	{ name = "purple tapestry", id = 2644, buy = 25 },
	{ name = "red cushioned chair", id = 2775, buy = 40 },
	{ name = "red pillow", id = 2395, buy = 25 },
	{ name = "red tapestry", id = 2656, buy = 25 },
	{ name = "rocking chair", id = 2778, buy = 25 },
	{ name = "rocking horse", id = 2800, buy = 30 },
	{ name = "round blue pillow", id = 2398, buy = 25 },
	{ name = "round purple pillow", id = 2400, buy = 25 },
	{ name = "round red pillow", id = 2399, buy = 25 },
	{ name = "round turquoise pillow", id = 2401, buy = 25 },
	{ name = "small blue pillow", id = 2389, buy = 20 },
	{ name = "small green pillow", id = 2387, buy = 20 },
	{ name = "small orange pillow", id = 2390, buy = 20 },
	{ name = "small purple pillow", id = 2386, buy = 20 },
	{ name = "small red pillow", id = 2388, buy = 20 },
	{ name = "small round table", id = 2783, buy = 25 },
	{ name = "small table", id = 2782, buy = 20 },
	{ name = "small turquoise pillow", id = 2391, buy = 20 },
	{ name = "small white pillow", id = 2392, buy = 20 },
	{ name = "sofa chair", id = 2779, buy = 55 },
	{ name = "square table", id = 2784, buy = 25 },
	{ name = "table lamp", id = 2798, buy = 35 },
	{ name = "telescope", id = 2799, buy = 70 },
	{ name = "treasure quest", id = 2478, buy = 1000 },
	{ name = "trophy stand", id = 872, buy = 50 },
	{ name = "trough", id = 2792, buy = 7 },
	{ name = "venorean cabinet", id = 17974, buy = 90 },
	{ name = "venorean drawer", id = 17977, buy = 40 },
	{ name = "venorean wardrobe", id = 17975, buy = 50 },
	{ name = "wall mirror", id = 2638, buy = 40 },
	{ name = "water pipe", id = 2974, buy = 40 },
	{ name = "weapon rack", id = 6115, buy = 90 },
	{ name = "white tapestry", id = 2667, buy = 25 },
	{ name = "wooden chair", id = 2777, buy = 15 },
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
	local items = {[1] = 3074, [2] = 3066}
	local itemId = items[player:getVocation():getBase():getId()]
	if msgcontains(msg, 'first rod') or msgcontains(msg, 'first wand') then
		if player:isMage() then
			if player:getStorageValue(Storage.firstMageWeapon) == -1 then
				npcHandler:say('So you ask me for a {' .. ItemType(itemId):getName() .. '} to begin your adventure?', cid)
				npcHandler.topic[cid] = 1
			else
				npcHandler:say('What? I have already gave you one {' .. ItemType(itemId):getName() .. '}!', cid)
			end
		else
			npcHandler:say('Sorry, you aren\'t a druid either a sorcerer.', cid)
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			player:addItem(itemId, 1)
			npcHandler:say('Here you are young adept, take care yourself.', cid)
			player:setStorageValue(Storage.firstMageWeapon, 1)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		npcHandler:say('Ok then.', cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
