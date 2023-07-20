local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function getTable(player)
local itemsList = {}
	
local buyList= {
	{ name = "arrow", id = 3447, buy = 3 },
	{ name = "blue quiver", id = 35848, buy = 400 },
	{ name = "bolt", id = 3446, buy = 4 },
	{ name = "bow", id = 3350, buy = 400, sell = 100 },
	{ name = "crossbow", id = 3349, buy = 500, sell = 120 },
	{ name = "crystalline arrow", id = 15793, buy = 20 },
	{ name = "diamond arrow", id = 35901, buy = 100 },
	{ name = "drill bolt", id = 16142, buy = 12 },
	{ name = "earth arrow", id = 774, buy = 5 },
	{ name = "envenomed arrow", id = 16143, buy = 12 },
	{ name = "flaming arrow", id = 763, buy = 5 },
	{ name = "flash arrow", id = 761, buy = 5 },
	{ name = "onyx arrow", id = 7365, buy = 7 },
	{ name = "piercing bolt", id = 7363, buy = 5 },
	{ name = "power bolt", id = 3450, buy = 7 },
	{ name = "prismatic bolt", id = 16141, buy = 20 },
	{ name = "quiver", id = 35562, buy = 400 },
	{ name = "red quiver", id = 35849, buy = 400 },
	{ name = "royal spear", id = 7378, buy = 15 },
	{ name = "shiver arrow", id = 762, buy = 5 },
	{ name = "sniper arrow", id = 7364, buy = 5 },
	{ name = "spear", id = 3277, buy = 9, sell = 3 },
	{ name = "spectral bolt", id = 35902, buy = 70 },
	{ name = "tarsal arrow", id = 14251, buy = 6 },
	{ name = "throwing star", id = 3287, buy = 42 },
	{ name = "vortex bolt", id = 14252, buy = 6 }
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
	
	return true
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
