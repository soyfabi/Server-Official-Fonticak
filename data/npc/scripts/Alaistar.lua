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
	{ name = "cowbell", id = 21204, sell = 210 },
	{ name = "empty potion flask", id = 283, sell = 5 },
	{ name = "empty potion flask", id = 284, sell = 5 },
	{ name = "empty potion flask", id = 285, sell = 5 },
	{ name = "execowtioner mask", id = 21201, sell = 240 },
	{ name = "giant pacifier", id = 21199, sell = 170 },
	{ name = "glob of glooth", id = 21182, sell = 125 },
	{ name = "glooth injection tube", id = 21103, sell = 350 },
	{ name = "great health potion", id = 239, buy = 225 },
	{ name = "great mana potion", id = 238, buy = 144 },
	{ name = "great spirit potion", id = 7642, buy = 228 },
	{ name = "health potion", id = 266, buy = 50 },
	{ name = "mana potion", id = 268, buy = 56 },
	{ name = "metal jaw", id = 21193, sell = 260 },
	{ name = "metal toe", id = 21198, sell = 430 },
	{ name = "mooh'tah shell", id = 21202, sell = 110 },
	{ name = "moohtant horn", id = 21200, sell = 140 },
	{ name = "necromantic rust", id = 21196, sell = 390 },
	{ name = "poisoned fang", id = 21195, sell = 130 },
	{ name = "seacrest hair", id = 21801, sell = 260 },
	{ name = "seacrest pearl", id = 21747, sell = 400 },
	{ name = "seacrest scale", id = 21800, sell = 150 },
	{ name = "slime heart", id = 21194, sell = 160 },
	{ name = "slimy leaf tentacle", id = 21197, sell = 320 },
	{ name = "strong health potion", id = 236, buy = 115 },
	{ name = "strong mana potion", id = 237, buy = 93 },
	{ name = "supreme health potion", id = 23375, buy = 625 },
	{ name = "ultimate health potion", id = 7643, buy = 438 },
	{ name = "ultimate mana potion", id = 23373, buy = 379 },
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
		npcHandler:say("Of course, just browse through my wares. Or do you want to look only at {potions}, {wands} or {runes}?", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
