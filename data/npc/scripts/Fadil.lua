 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "collar of blue plasma", id = 23542, sell = 6000 },
	{ name = "collar of green plasma", id = 23543, sell = 6000 },
	{ name = "collar of red plasma", id = 23544, sell = 6000 },
	{ name = "condensed energy", id = 23501, sell = 260 },
	{ name = "crystal bone", id = 23521, sell = 250 },
	{ name = "crystallized anger", id = 23507, sell = 400 },
	{ name = "curious matter", id = 23511, sell = 430 },
	{ name = "dangerous proto matter", id = 23515, sell = 300 },
	{ name = "energy ball", id = 23523, sell = 300 },
	{ name = "energy vein", id = 23508, sell = 270 },
	{ name = "frozen lightning", id = 23519, sell = 270 },
	{ name = "glistening bone", id = 23522, sell = 250 },
	{ name = "green bandage", id = 25697, sell = 180 },
	{ name = "instable proto matter", id = 23516, sell = 300 },
	{ name = "little bowl of myrrh", id = 25702, sell = 500 },
	{ name = "odd organ", id = 23510, sell = 410 },
	{ name = "plasma pearls", id = 23506, sell = 250 },
	{ name = "plasmatic lightning", id = 23520, sell = 270 },
	{ name = "ring of blue plasma", id = 23529, sell = 8000 },
	{ name = "ring of green plasma", id = 23531, sell = 8000 },
	{ name = "ring of red plasma", id = 23533, sell = 8000 },
	{ name = "single human eye", id = 25701, sell = 1000 },
	{ name = "small energy ball", id = 23524, sell = 250 },
	{ name = "solid rage", id = 23517, sell = 310 },
	{ name = "spark sphere", id = 23518, sell = 350 },
	{ name = "sparkion claw", id = 23502, sell = 290 },
	{ name = "sparkion legs", id = 23504, sell = 310 },
	{ name = "sparkion stings", id = 23505, sell = 280 },
	{ name = "sparkion tail", id = 23503, sell = 300 },
	{ name = "strange proto matter", id = 23513, sell = 300 },
	{ name = "volatile proto matter", id = 23514, sell = 300 }
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
		npcHandler:say("I buy all kinds of accessories, {rings}, {amulets}, {rare objects}.", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
